import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The slice of key/value storage this app needs.
///
/// Exists so tests can supply an in-memory store: `flutter_secure_storage` is
/// platform-backed and unavailable under `flutter test`.
abstract class SecureKeyValueStore {
  Future<String?> read({required String key});
  Future<void> write({required String key, required String? value});
  Future<void> delete({required String key});
}

/// Production adapter over platform secure storage.
class FlutterSecureKeyValueStore implements SecureKeyValueStore {
  const FlutterSecureKeyValueStore([this._storage = _defaultStorage]);

  static const _defaultStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read({required String key}) => _storage.read(key: key);

  @override
  Future<void> write({required String key, required String? value}) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete({required String key}) => _storage.delete(key: key);
}

/// Persists the auth session (tokens + cached user) in secure storage.
///
/// The access token is mirrored in memory so the request interceptor stays
/// synchronous on the hot path; disk is touched only on login/logout and once
/// at startup.
class TokenStorage {
  TokenStorage({SecureKeyValueStore? store})
      : _store = store ?? const FlutterSecureKeyValueStore();

  final SecureKeyValueStore _store;

  static const _kAccessToken = 'plans.accessToken';
  static const _kRefreshToken = 'plans.refreshToken';
  static const _kUser = 'plans.user';

  String? _cachedAccessToken;
  String? _cachedRefreshToken;

  String? get accessToken => _cachedAccessToken;
  String? get refreshToken => _cachedRefreshToken;
  bool get hasSession => (_cachedAccessToken ?? '').isNotEmpty;

  /// Loads any persisted session into memory. Safe at startup: a storage
  /// failure degrades to "logged out" rather than crashing the app.
  Future<void> restore() async {
    try {
      _cachedAccessToken = await _store.read(key: _kAccessToken);
      _cachedRefreshToken = await _store.read(key: _kRefreshToken);
    } catch (e) {
      debugPrint('TokenStorage.restore failed: $e');
      _cachedAccessToken = null;
      _cachedRefreshToken = null;
    }
  }

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    _cachedRefreshToken = refreshToken;
    try {
      await _store.write(key: _kAccessToken, value: accessToken);
      if (refreshToken != null) {
        await _store.write(key: _kRefreshToken, value: refreshToken);
      }
    } catch (e) {
      // Keep the in-memory session: the user stays logged in for this run.
      debugPrint('TokenStorage.saveTokens failed: $e');
    }
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    try {
      await _store.write(key: _kUser, value: jsonEncode(user));
    } catch (e) {
      debugPrint('TokenStorage.saveUser failed: $e');
    }
  }

  Future<Map<String, dynamic>?> readUser() async {
    try {
      final raw = await _store.read(key: _kUser);
      if (raw == null || raw.isEmpty) return null;
      final decoded = jsonDecode(raw);
      return decoded is Map ? Map<String, dynamic>.from(decoded) : null;
    } catch (e) {
      debugPrint('TokenStorage.readUser failed: $e');
      return null;
    }
  }

  Future<void> clear() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    try {
      await _store.delete(key: _kAccessToken);
      await _store.delete(key: _kRefreshToken);
      await _store.delete(key: _kUser);
    } catch (e) {
      debugPrint('TokenStorage.clear failed: $e');
    }
  }
}
