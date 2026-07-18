import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudiaaaa/app.dart';
import 'package:saudiaaaa/core/di/app_bloc_providers.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';

void main() {
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

  runApp(
    ProviderScope(
      overrides: [
        // Riverpod-side features share the same client as the Bloc-side auth,
        // so one token and one 401 channel govern every request.
        apiServiceProvider.overrideWithValue(dependencies.apiService),
      ],
      child: AppBlocProviders(
        dependencies: dependencies,
        child: const PlansApp(),
      ),
    ),
  );
}
