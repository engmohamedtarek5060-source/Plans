import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudiaaaa/app.dart';
import 'package:saudiaaaa/core/di/app_bloc_providers.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:saudiaaaa/features/settings/domain/usecases/load_settings.dart';
import 'package:saudiaaaa/features/settings/presentation/controllers/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inter and Tajawal ship in assets/google_fonts/. Without this, google_fonts
  // downloads them from fonts.gstatic.com on first paint — which delays the
  // first frame and throws an unhandled exception on a slow or offline
  // network. Fonts are a hard dependency of the UI, not a runtime fetch.
  GoogleFonts.config.allowRuntimeFetching = false;

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  final dependencies = AppDependencies.create();

  // Awaited before the first frame, unlike the role and the session which
  // resolve behind an in-app splash. `MaterialApp` reads its theme and locale
  // synchronously, so loading these afterwards would paint the default
  // appearance and language for a frame and then visibly correct itself. The
  // read is bounded by SettingsStorage's own timeout, so a wedged keystore
  // delays startup by at most that long and then starts with defaults.
  final settings = await LoadSettings(
    SettingsRepositoryImpl(dependencies.settingsStorage),
  )();

  runApp(
    ProviderScope(
      overrides: [
        // Riverpod-side features share the same client as the Bloc-side auth,
        // so one token and one 401 channel govern every request.
        apiServiceProvider.overrideWithValue(dependencies.apiService),
        roleStorageProvider.overrideWithValue(dependencies.roleStorage),
        settingsStorageProvider.overrideWithValue(dependencies.settingsStorage),
        bootstrapSettingsProvider.overrideWithValue(settings),
      ],
      child: AppBlocProviders(
        dependencies: dependencies,
        child: const PlansApp(),
      ),
    ),
  );
}
