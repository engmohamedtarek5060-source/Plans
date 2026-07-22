import 'package:flutter/foundation.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';

/// Persists the appearance and language chosen in settings.
///
/// Shares [SecureKeyValueStore] with [TokenStorage] and [RoleStorage] for the
/// same reason spelled out there: one storage seam to fake in tests, one place
/// where platform failures are handled. Neither value is a secret; the app
/// simply has exactly one key/value store.
class SettingsStorage {
  SettingsStorage({SecureKeyValueStore? store})
      : _store = store ?? const FlutterSecureKeyValueStore();

  final SecureKeyValueStore _store;

  static const _kThemeMode = 'plans.themeMode';

  /// Named `locale` rather than `language` because it is the locale's code
  /// that is stored, and the key is a contract that outlives this class.
  static const _kLanguage = 'plans.locale';

  /// Shorter than [RoleStorage]'s five seconds, deliberately. The role is read
  /// after `runApp` behind an animated in-app splash; these are read *before*
  /// the first frame, where the user is staring at a frozen native splash. Two
  /// seconds is the most a wedged keystore may cost before the app gives up and
  /// starts with defaults.
  static const _readTimeout = Duration(seconds: 2);

  Future<String?> readThemeMode() => _read(_kThemeMode);

  Future<String?> readLanguage() => _read(_kLanguage);

  Future<void> writeThemeMode(String value) => _write(_kThemeMode, value);

  Future<void> writeLanguage(String value) => _write(_kLanguage, value);

  Future<void> clear() async {
    await Future.wait([_delete(_kThemeMode), _delete(_kLanguage)]);
  }

  /// The raw stored value, or null when absent, unreadable, or too slow.
  ///
  /// Every failure degrades to "nothing chosen", which the repository resolves
  /// to the fallback: the app opens with system theme and its default language
  /// instead of hanging on a splash it can never leave.
  Future<String?> _read(String key) async {
    try {
      return await _store.read(key: key).timeout(_readTimeout);
    } catch (e) {
      debugPrint('SettingsStorage read of $key failed: $e');
      return null;
    }
  }

  Future<void> _write(String key, String value) async {
    try {
      await _store.write(key: key, value: value);
    } catch (e) {
      // Swallowed deliberately, matching RoleStorage: the preference is already
      // applied in memory for this run, so the user sees their choice take
      // effect and only the next cold start would forget it.
      debugPrint('SettingsStorage write of $key failed: $e');
    }
  }

  Future<void> _delete(String key) async {
    try {
      await _store.delete(key: key);
    } catch (e) {
      debugPrint('SettingsStorage delete of $key failed: $e');
    }
  }
}
