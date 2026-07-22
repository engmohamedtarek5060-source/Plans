import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/storage/settings_storage.dart';
import 'package:saudiaaaa/core/theme/theme_provider.dart';
import 'package:saudiaaaa/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_language.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_settings.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_theme_mode.dart';
import 'package:saudiaaaa/features/settings/domain/usecases/load_settings.dart';
import 'package:saudiaaaa/features/settings/presentation/controllers/settings_controller.dart';

/// In-memory secure storage stand-in (platform storage is unavailable under
/// `flutter test`).
class _InMemoryStore implements SecureKeyValueStore {
  _InMemoryStore([Map<String, String>? seed]) : values = {...?seed};

  final Map<String, String> values;

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

/// Every operation fails, standing in for a locked or unavailable keystore.
class _ThrowingStore implements SecureKeyValueStore {
  @override
  Future<String?> read({required String key}) async =>
      throw StateError('keystore unavailable');

  @override
  Future<void> write({required String key, required String? value}) async =>
      throw StateError('keystore unavailable');

  @override
  Future<void> delete({required String key}) async =>
      throw StateError('keystore unavailable');
}

/// Reads never answer, standing in for a wedged platform channel.
class _HangingStore implements SecureKeyValueStore {
  @override
  Future<String?> read({required String key}) => Completer<String?>().future;

  @override
  Future<void> write({required String key, required String? value}) async {}

  @override
  Future<void> delete({required String key}) async {}
}

ProviderContainer _container(
  SecureKeyValueStore store, {
  AppSettings? bootstrap,
}) {
  final container = ProviderContainer(
    overrides: [
      settingsStorageProvider.overrideWithValue(SettingsStorage(store: store)),
      if (bootstrap != null)
        bootstrapSettingsProvider.overrideWithValue(bootstrap),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('AppThemeMode parsing', () {
    test('round-trips every stored value', () {
      for (final mode in AppThemeMode.values) {
        expect(AppThemeMode.fromStorage(mode.storageValue), mode);
      }
    });

    test('treats absent, empty and unknown values as not chosen', () {
      expect(AppThemeMode.fromStorage(null), isNull);
      expect(AppThemeMode.fromStorage(''), isNull);
      expect(AppThemeMode.fromStorage('midnight'), isNull);
      // Case matters: the stored contract is lowercase.
      expect(AppThemeMode.fromStorage('DARK'), isNull);
    });
  });

  group('AppLanguage parsing', () {
    test('round-trips every stored value and carries its direction', () {
      for (final language in AppLanguage.values) {
        expect(AppLanguage.fromStorage(language.storageValue), language);
      }
      expect(AppLanguage.arabic.isRtl, isTrue);
      expect(AppLanguage.english.isRtl, isFalse);
      expect(AppLanguage.arabic.opposite, AppLanguage.english);
      expect(AppLanguage.english.opposite, AppLanguage.arabic);
    });

    test('treats absent, empty and unsupported codes as not chosen', () {
      expect(AppLanguage.fromStorage(null), isNull);
      expect(AppLanguage.fromStorage(''), isNull);
      expect(AppLanguage.fromStorage('fr'), isNull);
    });
  });

  group('SettingsRepositoryImpl', () {
    test('falls back to system theme and Arabic when nothing is stored',
        () async {
      final repository =
          SettingsRepositoryImpl(SettingsStorage(store: _InMemoryStore()));

      expect(await repository.load(), AppSettings.fallback);
    });

    test('loads what was previously saved', () async {
      final store = _InMemoryStore();
      final repository = SettingsRepositoryImpl(SettingsStorage(store: store));

      await repository.saveThemeMode(AppThemeMode.dark);
      await repository.saveLanguage(AppLanguage.english);

      expect(
        await repository.load(),
        const AppSettings(
          themeMode: AppThemeMode.dark,
          language: AppLanguage.english,
        ),
      );
    });

    test('writes under the documented keys', () async {
      final store = _InMemoryStore();
      final repository = SettingsStorage(store: store);

      await SettingsRepositoryImpl(repository)
          .saveThemeMode(AppThemeMode.light);
      await SettingsRepositoryImpl(repository)
          .saveLanguage(AppLanguage.english);

      // Literal keys: changing them silently resets every installed device.
      expect(store.values['plans.themeMode'], 'light');
      expect(store.values['plans.locale'], 'en');
    });

    test('resolves each preference independently', () async {
      // Only the language was ever changed; the theme must still fall back
      // rather than dragging the whole object to defaults.
      final store = _InMemoryStore({'plans.locale': 'en'});

      expect(
        await SettingsRepositoryImpl(SettingsStorage(store: store)).load(),
        const AppSettings(
          themeMode: AppThemeMode.system,
          language: AppLanguage.english,
        ),
      );
    });

    test('ignores a corrupted value rather than failing to start', () async {
      final store = _InMemoryStore({
        'plans.themeMode': 'neon',
        'plans.locale': 'de',
      });

      expect(
        await SettingsRepositoryImpl(SettingsStorage(store: store)).load(),
        AppSettings.fallback,
      );
    });

    test('degrades to defaults when the keystore throws', () async {
      final repository =
          SettingsRepositoryImpl(SettingsStorage(store: _ThrowingStore()));

      expect(await repository.load(), AppSettings.fallback);
      // A failed write must not surface: the choice already applies in memory.
      await expectLater(
        repository.saveThemeMode(AppThemeMode.dark),
        completes,
      );
      await expectLater(
        repository.saveLanguage(AppLanguage.english),
        completes,
      );
    });

    // testWidgets, not test: it runs in a fake-async zone, so the read timeout
    // can be elapsed instantly instead of stalling the suite for two seconds.
    testWidgets('gives up on a wedged keystore instead of blocking startup',
        (WidgetTester tester) async {
      AppSettings? loaded;
      unawaited(
        SettingsRepositoryImpl(SettingsStorage(store: _HangingStore()))
            .load()
            .then((value) => loaded = value),
      );

      await tester.pump(const Duration(seconds: 1));
      expect(loaded, isNull, reason: 'still within the read timeout');

      await tester.pump(const Duration(seconds: 2));
      expect(loaded, AppSettings.fallback);
    });
  });

  group('ThemeModeNotifier', () {
    test('starts from the preferences resolved before the first frame', () {
      final container = _container(
        _InMemoryStore(),
        bootstrap: const AppSettings(
          themeMode: AppThemeMode.dark,
          language: AppLanguage.arabic,
        ),
      );

      expect(container.read(themeModeProvider), ThemeMode.dark);
    });

    test('defaults to following the system when nothing was loaded', () {
      expect(
        _container(_InMemoryStore()).read(themeModeProvider),
        ThemeMode.system,
      );
    });

    test('persists a change', () async {
      final store = _InMemoryStore();
      final container = _container(store);

      container.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark);

      expect(container.read(themeModeProvider), ThemeMode.dark);
      // The write is unawaited so the repaint isn't delayed; let it land.
      await pumpEventQueue();
      expect(store.values['plans.themeMode'], 'dark');
    });

    test('toggles light and dark, and leaves system for dark', () async {
      final container = _container(_InMemoryStore());
      final notifier = container.read(themeModeProvider.notifier);

      notifier.toggle();
      expect(container.read(themeModeProvider), ThemeMode.dark);
      notifier.toggle();
      expect(container.read(themeModeProvider), ThemeMode.light);
    });

    test('a failed write still applies the choice for this run', () async {
      final container = _container(_ThrowingStore());

      container.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light);
      await pumpEventQueue();

      expect(container.read(themeModeProvider), ThemeMode.light);
    });
  });

  group('LocaleNotifier', () {
    test('starts from the preferences resolved before the first frame', () {
      final container = _container(
        _InMemoryStore(),
        bootstrap: const AppSettings(
          themeMode: AppThemeMode.system,
          language: AppLanguage.english,
        ),
      );

      expect(container.read(localeProvider), const Locale('en'));
      expect(container.read(localeProvider.notifier).isArabic, isFalse);
      expect(
        container.read(localeProvider.notifier).textDirection,
        TextDirection.ltr,
      );
    });

    test('defaults to Arabic, matching the pre-persistence behaviour', () {
      final container = _container(_InMemoryStore());

      expect(container.read(localeProvider), const Locale('ar'));
      expect(
        container.read(localeProvider.notifier).textDirection,
        TextDirection.rtl,
      );
    });

    test('toggling persists the new language and flips direction', () async {
      final store = _InMemoryStore();
      final container = _container(store);

      container.read(localeProvider.notifier).toggle();

      expect(container.read(localeProvider), const Locale('en'));
      expect(
        container.read(localeProvider.notifier).textDirection,
        TextDirection.ltr,
      );
      await pumpEventQueue();
      expect(store.values['plans.locale'], 'en');
    });

    test('notifies listeners so the app rebuilds on a language change', () {
      final container = _container(_InMemoryStore());
      final seen = <Locale>[];
      container.listen(localeProvider, (_, next) => seen.add(next));

      container.read(localeProvider.notifier).toggle();
      container.read(localeProvider.notifier).toggle();

      expect(seen, [const Locale('en'), const Locale('ar')]);
    });

    test('ignores an unsupported locale rather than rendering nothing',
        () async {
      final store = _InMemoryStore();
      final container = _container(store);

      container.read(localeProvider.notifier).setLocale(const Locale('fr'));

      expect(container.read(localeProvider), const Locale('ar'));
      await pumpEventQueue();
      expect(store.values.containsKey('plans.locale'), isFalse);
    });

    test('re-selecting the current language writes nothing', () async {
      final store = _InMemoryStore();
      final container = _container(store);

      container.read(localeProvider.notifier).setLocale(const Locale('ar'));
      await pumpEventQueue();

      expect(store.values.containsKey('plans.locale'), isFalse);
    });
  });

  group('LoadSettings', () {
    test('reads through the repository', () async {
      final store = _InMemoryStore({
        'plans.themeMode': 'light',
        'plans.locale': 'en',
      });

      final settings = await LoadSettings(
        SettingsRepositoryImpl(SettingsStorage(store: store)),
      )();

      expect(settings.themeMode, AppThemeMode.light);
      expect(settings.language, AppLanguage.english);
    });
  });
}
