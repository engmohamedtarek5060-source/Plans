import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';

/// Branded launch screen with coordinated entrance motion.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final AnimationController _pulse;
  late final AnimationController _drift;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoRotate;
  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _taglineOpacity;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _ringExpand;
  late final Animation<double> _ringFade;
  late final Animation<double> _loaderOpacity;

  @override
  void initState() {
    super.initState();

    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _drift = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 9000),
    )..repeat();

    _logoScale = Tween<double>(begin: 0.55, end: 1).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.0, 0.55, curve: Curves.elasticOut),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.0, 0.28, curve: Curves.easeOut),
      ),
    );
    _logoRotate = Tween<double>(begin: -0.08, end: 0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _titleOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.32, 0.62, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.32, 0.68, curve: Curves.easeOutCubic),
      ),
    );

    _taglineOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.48, 0.78, curve: Curves.easeOut),
      ),
    );
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.48, 0.82, curve: Curves.easeOutCubic),
      ),
    );

    _ringExpand = Tween<double>(begin: 0.7, end: 1.55).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.08, 0.72, curve: Curves.easeOutCubic),
      ),
    );
    _ringFade = Tween<double>(begin: 0.55, end: 0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.2, 0.85, curve: Curves.easeOut),
      ),
    );

    _loaderOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.62, 0.92, curve: Curves.easeOut),
      ),
    );

    _entrance.forward();
  }

  @override
  void dispose() {
    _entrance.dispose();
    _pulse.dispose();
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final colors = context.appColors;
    final isDark = context.isDarkMode;

    return Scaffold(
      body: PremiumBackground(
        child: AnimatedBuilder(
          animation: Listenable.merge([_entrance, _pulse, _drift]),
          builder: (context, _) {
            return Stack(
              fit: StackFit.expand,
              children: [
                _FloatingSpecks(progress: _drift.value, isDark: isDark),
                _DriftingOrb(
                  alignment: Alignment(
                    -0.85 + 0.08 * math.sin(_drift.value * math.pi * 2),
                    -0.75 + 0.06 * math.cos(_drift.value * math.pi * 2),
                  ),
                  color: AppColors.brandPrimary,
                  size: 220,
                  opacity: isDark ? 0.22 : 0.16,
                ),
                _DriftingOrb(
                  alignment: Alignment(
                    0.9 + 0.07 * math.cos(_drift.value * math.pi * 2),
                    0.7 + 0.09 * math.sin(_drift.value * math.pi * 2),
                  ),
                  color: AppColors.brandAccent,
                  size: 260,
                  opacity: isDark ? 0.16 : 0.11,
                ),
                SafeArea(
                  child: Column(
                    children: [
                      const Spacer(flex: 3),
                      _BrandCluster(
                        logoScale: _logoScale.value,
                        logoOpacity: _logoOpacity.value,
                        logoRotate: _logoRotate.value,
                        ringExpand: _ringExpand.value,
                        ringFade: _ringFade.value,
                        pulse: _pulse.value,
                        isDark: isDark,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      SlideTransition(
                        position: _titleSlide,
                        child: FadeTransition(
                          opacity: _titleOpacity,
                          child: Text(
                            AppStrings.appName(isArabic),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.6,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SlideTransition(
                        position: _taglineSlide,
                        child: FadeTransition(
                          opacity: _taglineOpacity,
                          child: Text(
                            AppStrings.splashTagline(isArabic),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: colors.textSecondary,
                                  height: 1.4,
                                ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 4),
                      Opacity(
                        opacity: _loaderOpacity.value,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                          child: _SplashLoader(pulse: _pulse.value),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BrandCluster extends StatelessWidget {
  const _BrandCluster({
    required this.logoScale,
    required this.logoOpacity,
    required this.logoRotate,
    required this.ringExpand,
    required this.ringFade,
    required this.pulse,
    required this.isDark,
  });

  final double logoScale;
  final double logoOpacity;
  final double logoRotate;
  final double ringExpand;
  final double ringFade;
  final double pulse;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final breath = 1 + 0.04 * math.sin(pulse * math.pi * 2);
    final glowPulse = 0.55 + 0.45 * ((math.sin(pulse * math.pi * 2) + 1) / 2);

    return SizedBox(
      width: 168,
      height: 168,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: ringExpand,
            child: Opacity(
              opacity: ringFade,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.brandPrimary.withValues(alpha: 0.45),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: 1 + (ringExpand - 0.7) * 0.55,
            child: Opacity(
              opacity: (ringFade * 0.7).clamp(0.0, 1.0),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.brandAccent.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: logoOpacity,
            child: Transform.rotate(
              angle: logoRotate,
              child: Transform.scale(
                scale: logoScale * breath,
                child: Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    gradient: AppColors.brandGradient,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      ...AppEffects.glowShadow(
                        AppColors.brandPrimary,
                        blur: 28 + 10 * glowPulse,
                      ),
                      BoxShadow(
                        color: AppColors.brandAccent.withValues(
                          alpha: 0.18 * glowPulse,
                        ),
                        blurRadius: 36,
                        spreadRadius: -4,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: isDark ? 0.14 : 0.28,
                      ),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      'assets/images/logo.jpeg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.insights_rounded,
                        color: Colors.white,
                        size: 52,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashLoader extends StatelessWidget {
  const _SplashLoader({required this.pulse});

  final double pulse;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: SizedBox(
              height: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ColoredBox(
                    color: AppColors.brandPrimary.withValues(alpha: 0.12),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment(
                      -1 + 2 * ((math.sin(pulse * math.pi * 2) + 1) / 2),
                      0,
                    ),
                    widthFactor: 0.38,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.brandPrimaryLight,
                            AppColors.brandPrimary,
                            AppColors.brandAccent,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final phase = (pulse + index * 0.22) % 1;
              final bounce = math.sin(phase * math.pi);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Transform.translate(
                  offset: Offset(0, -4 * bounce),
                  child: Opacity(
                    opacity: 0.35 + 0.65 * bounce,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 1
                            ? AppColors.brandAccent
                            : AppColors.brandPrimary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _DriftingOrb extends StatelessWidget {
  const _DriftingOrb({
    required this.alignment,
    required this.color,
    required this.size,
    required this.opacity,
  });

  final Alignment alignment;
  final Color color;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: opacity),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingSpecks extends StatelessWidget {
  const _FloatingSpecks({required this.progress, required this.isDark});

  final double progress;
  final bool isDark;

  static const _seeds = <(double, double, double, double)>[
    (0.18, 0.22, 3.0, 0.0),
    (0.78, 0.18, 2.5, 0.2),
    (0.12, 0.58, 2.0, 0.45),
    (0.88, 0.48, 3.5, 0.65),
    (0.32, 0.78, 2.2, 0.15),
    (0.62, 0.72, 2.8, 0.8),
    (0.48, 0.28, 2.0, 0.35),
    (0.72, 0.88, 2.4, 0.55),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return IgnorePointer(
          child: Stack(
            children: [
              for (final (x, y, size, phase) in _seeds)
                Positioned(
                  left: constraints.maxWidth * x +
                      10 * math.sin((progress + phase) * math.pi * 2),
                  top: constraints.maxHeight * y +
                      14 * math.cos((progress + phase) * math.pi * 2),
                  child: Opacity(
                    opacity: isDark ? 0.35 : 0.28,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: phase > 0.5
                            ? AppColors.brandAccent
                            : AppColors.brandPrimaryLight,
                        boxShadow: [
                          BoxShadow(
                            color: (phase > 0.5
                                    ? AppColors.brandAccent
                                    : AppColors.brandPrimary)
                                .withValues(alpha: 0.45),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
