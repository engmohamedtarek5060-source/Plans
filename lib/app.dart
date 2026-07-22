import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_theme.dart';
import 'package:saudiaaaa/core/theme/theme_provider.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/app_root.dart';

class PlansApp extends ConsumerWidget {
  const PlansApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    // Watch the state so a language change rebuilds this and, through it, every
    // screen below — that is what makes the switch take effect app-wide.
    final locale = ref.watch(localeProvider);
    final languages = ref.watch(localeProvider.notifier);
    final isArabic = languages.isArabic;

    return MaterialApp(
      title: 'Plans ERP',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light(isArabic: isArabic),
      darkTheme: AppTheme.dark(isArabic: isArabic),
      locale: locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        // Clamp the OS font scale so an extreme accessibility setting can't
        // overflow tight layouts, while still honouring larger text up to a
        // safe bound.
        final mq = MediaQuery.of(context);
        final scale = mq.textScaler.clamp(
          minScaleFactor: 0.85,
          maxScaleFactor: 1.3,
        );
        return MediaQuery(
          data: mq.copyWith(textScaler: scale),
          child: Directionality(
            // From the language itself, so direction and strings can never
            // disagree about which language is active.
            textDirection: languages.textDirection,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: const AppRoot(),
    );
  }
}
