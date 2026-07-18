import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';

/// Ambient mesh background with soft gradient orbs.
class PremiumBackground extends StatelessWidget {
  const PremiumBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final orbs = AppEffects.ambientOrbs(isDark: isDark);

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppEffects.meshGradient(isDark: isDark),
          ),
        ),
        Positioned(
          top: -80,
          right: -60,
          child: _Orb(gradient: orbs[0], size: 280),
        ),
        Positioned(
          bottom: 120,
          left: -100,
          child: _Orb(gradient: orbs[1], size: 320),
        ),
        child,
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.gradient, required this.size});

  final RadialGradient gradient;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: gradient),
      ),
    );
  }
}
