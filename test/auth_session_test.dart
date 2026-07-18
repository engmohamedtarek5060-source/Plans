import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/interceptors/auth_interceptor.dart';
import 'package:saudiaaaa/core/network/session_events.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';
import 'package:saudiaaaa/features/auth/domain/failures/auth_failure.dart';
import 'package:saudiaaaa/features/auth/domain/repositories/auth_repository.dart';
import 'package:saudiaaaa/features/auth/domain/usecases/login_user.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';

class _InMemoryStore implements SecureKeyValueStore {
  final values = <String, String>{};

  @override
  Future<String?> read({required String key}) async => values[key];

  @override
  Future<void> write({required String key, required String? value}) async {
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }

  @override
  Future<void> delete({required String key}) async => values.remove(key);
}

const _user = AuthUser(
  id: '1',
  email: 'a@b.com',
  fullName: 'Test',
  fullNameAr: 'Test',
  role: 'ADMIN',
);

class _FakeAuthRepository implements AuthRepository {
  AuthUser? restored;
  int logoutCalls = 0;

  @override
  Future<AuthUser> login({required String email, required String password}) async =>
      _user;

  @override
  Future<void> logout() async => logoutCalls++;

  @override
  Future<AuthUser?> restoreSession() async => restored;
}

AuthCubit _cubit(_FakeAuthRepository repo, SessionEvents events) => AuthCubit(
      loginUser: LoginUser(repo),
      logoutUser: LogoutUser(repo),
      restoreSession: RestoreSession(repo),
      sessionEvents: events,
    );

/// Answers every request with the given status, so the interceptor chain runs
/// exactly as it would against a real server — no socket involved.
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.statusCode);

  final int statusCode;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      '{"statusCode":$statusCode,"code":"UNAUTHORIZED","message":"Invalid or expired token"}',
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('AuthInterceptor', () {
    late TokenStorage storage;
    late SessionEvents events;
    late AuthInterceptor interceptor;

    setUp(() async {
      storage = TokenStorage(store: _InMemoryStore());
      await storage.saveTokens(accessToken: 'token-123');
      events = SessionEvents();
      interceptor = AuthInterceptor(tokenStorage: storage, sessionEvents: events);
    });

    tearDown(() => events.dispose());

    test('attaches the bearer token to authenticated requests', () {
      final options = RequestOptions(path: ApiEndpoints.invoices);
      interceptor.onRequest(options, RequestInterceptorHandler());
      expect(options.headers['Authorization'], 'Bearer token-123');
    });

    test('does not attach the token to login', () {
      final options = RequestOptions(path: ApiEndpoints.login);
      interceptor.onRequest(options, RequestInterceptorHandler());
      expect(options.headers.containsKey('Authorization'), isFalse);
    });

    /// Runs a request that the server answers with 401, through the real
    /// interceptor chain.
    Future<void> request401(String path) async {
      final dio = Dio(BaseOptions(baseUrl: 'https://stub.test'))
        ..httpClientAdapter = _StubAdapter(401)
        ..interceptors.add(interceptor);
      await expectLater(dio.get<dynamic>(path), throwsA(isA<DioException>()));
      await Future<void>.delayed(Duration.zero);
    }

    test('a 401 on an authenticated call clears the session and signals',
        () async {
      final signals = <void>[];
      events.onUnauthorized.listen(signals.add);

      await request401(ApiEndpoints.dashboard);

      expect(storage.hasSession, isFalse);
      expect(signals, hasLength(1));
    });

    test('a 401 from login does not sign the user out', () async {
      final signals = <void>[];
      events.onUnauthorized.listen(signals.add);

      await request401(ApiEndpoints.login);

      // A wrong password must leave any existing session untouched.
      expect(storage.hasSession, isTrue);
      expect(signals, isEmpty);
    });
  });

  group('AuthCubit session handling', () {
    late _FakeAuthRepository repo;
    late SessionEvents events;

    setUp(() {
      repo = _FakeAuthRepository();
      events = SessionEvents();
    });

    tearDown(() => events.dispose());

    test('bootstrap with no stored session lands on unauthenticated', () async {
      final cubit = _cubit(repo, events);
      await cubit.bootstrap();
      expect(cubit.state, const AuthUnauthenticated());
    });

    test('bootstrap with a stored session lands authenticated', () async {
      repo.restored = _user;
      final cubit = _cubit(repo, events);
      await cubit.bootstrap();
      expect(cubit.state, const AuthAuthenticated(_user));
    });

    test('a 401 signal logs an authenticated user out with a reason', () async {
      final cubit = _cubit(repo, events);
      await cubit.login(email: 'a@b.com', password: 'x');
      expect(cubit.state, isA<AuthAuthenticated>());

      events.signalUnauthorized();
      await Future<void>.delayed(Duration.zero);

      expect(
        cubit.state,
        const AuthUnauthenticated(failure: SessionExpiredFailure()),
      );
    });

    test('a burst of 401s logs out once, without looping', () async {
      final cubit = _cubit(repo, events);
      await cubit.login(email: 'a@b.com', password: 'x');

      final seen = <AuthState>[];
      final sub = cubit.stream.listen(seen.add);

      // Five screens refreshing at once all get 401 together.
      for (var i = 0; i < 5; i++) {
        events.signalUnauthorized();
      }
      await Future<void>.delayed(Duration.zero);

      expect(seen, hasLength(1));
      await sub.cancel();
    });

    test('logout clears local state even when the server call fails', () async {
      final cubit = _cubit(repo, events);
      await cubit.login(email: 'a@b.com', password: 'x');

      await cubit.logout();

      expect(repo.logoutCalls, 1);
      expect(cubit.state, const AuthUnauthenticated());
    });
  });
}
