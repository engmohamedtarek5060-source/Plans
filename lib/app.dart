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
    final locale = ref.watch(localeProvider);
    final isArabic = locale.languageCode == 'ar';

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
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: const AppRoot(),
    );
  }
}
