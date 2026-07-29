import 'package:saudiaaaa/core/network/api_exception.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';
import 'package:saudiaaaa/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:saudiaaaa/features/auth/data/models/auth_user_model.dart'
    show AuthUserModel, AuthSessionModel;
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';
import 'package:saudiaaaa/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required TokenStorage tokenStorage,
  })  : _remote = remote,
        _tokenStorage = tokenStorage;

  final AuthRemoteDataSource _remote;
  final TokenStorage _tokenStorage;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final session = await _remote.login(
      email: email.trim(),
      password: password,
    );
    return _persistSession(session, source: 'Login');
  }

  @override
  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
    required String companyName,
  }) async {
    final trimmedEmail = email.trim();
    final session = await _remote.register(
      name: name.trim(),
      email: trimmedEmail,
      password: password,
      companyName: companyName.trim(),
    );
    // Register normally returns the same envelope as login so the new account
    // is signed in immediately. If the account was created but tokens were
    // omitted, fall through to login with the credentials just submitted
    // rather than stranding the user on the register form.
    if (session.accessToken.isEmpty) {
      return login(email: trimmedEmail, password: password);
    }
    return _persistSession(session, source: 'Register');
  }

  /// Stores the tokens and user from an auth response, then returns the user.
  ///
  /// Persisting happens before returning: the token must be in place for the
  /// first authenticated request the UI fires on landing.
  Future<AuthUser> _persistSession(
    AuthSessionModel session, {
    required String source,
  }) async {
    if (session.accessToken.isEmpty) {
      throw ApiException.malformed(
        '$source response contained no access token',
      );
    }

    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    await _tokenStorage.saveUser(AuthUserModel.toJson(session.user));

    return session.user;
  }

  @override
  Future<void> logout() async {
    try {
      // Read before clearing: the backend needs the refresh token to revoke it.
      await _remote.logout(refreshToken: _tokenStorage.refreshToken);
    } on ApiException {
      // The local session must be dropped even if the server call fails,
      // otherwise a network blip would strand the user in a logged-in shell.
    } finally {
      await _tokenStorage.clear();
    }
  }

  @override
  Future<AuthUser?> restoreSession() async {
    await _tokenStorage.restore();
    if (!_tokenStorage.hasSession) return null;

    try {
      // Validate the stored token against the server rather than trusting it.
      final user = await _remote.me();
      await _tokenStorage.saveUser(AuthUserModel.toJson(user));
      return user;
    } on ApiException catch (e) {
      if (e.isUnauthorized) {
        await _tokenStorage.clear();
        return null;
      }
      // Offline or server trouble: fall back to the cached user so the app
      // opens instead of bouncing a valid session to the login screen.
      final cached = await _tokenStorage.readUser();
      return cached == null ? null : AuthUserModel.fromJson(cached);
    }
  }
}
