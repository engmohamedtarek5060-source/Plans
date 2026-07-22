import 'package:flutter/foundation.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';

/// Persists the entry role chosen on first launch.
///
/// Shares [SecureKeyValueStore] with [TokenStorage] so there is a single
/// storage seam to fake in tests and a single place where platform failures
/// are handled. The role is not itself a secret — it lives here because the
/// app already has exactly one key/value store, and adding a second mechanism
/// alongside it would mean two ways to persist and two ways to fail.
class RoleStorage {
  RoleStorage({SecureKeyValueStore? store})
      : _store = store ?? const FlutterSecureKeyValueStore();

  final SecureKeyValueStore _store;

  static const _kRole = 'plans.role';

  /// Platform storage can wedge rather than fail — a locked keystore, a stalled
  /// method channel — and this read gates the very first frame. Past this
  /// bound the app stops waiting, mirroring the session bootstrap timeout.
  static const _readTimeout = Duration(seconds: 5);

  /// The raw stored value, or null when absent, unreadable, or too slow.
  ///
  /// Every failure degrades to "no role chosen": the user picks again, which is
  /// recoverable, instead of the app hanging on a splash it can never leave.
  Future<String?> read() async {
    try {
      return await _store.read(key: _kRole).timeout(_readTimeout);
    } catch (e) {
      debugPrint('RoleStorage.read failed: $e');
      return null;
    }
  }

  Future<void> write(String value) async {
    try {
      await _store.write(key: _kRole, value: value);
    } catch (e) {
      // Swallowed deliberately, matching TokenStorage: the choice is already
      // held in memory for this run, so the user continues into their flow and
      // only the next cold start would ask again.
      debugPrint('RoleStorage.write failed: $e');
    }
  }

  Future<void> clear() async {
    try {
      await _store.delete(key: _kRole);
    } catch (e) {
      debugPrint('RoleStorage.clear failed: $e');
    }
  }
}
