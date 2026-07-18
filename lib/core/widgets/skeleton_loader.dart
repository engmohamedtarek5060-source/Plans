import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';

class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = AppSpacing.chipRadius,
  });

  final double? width;
  final double height;
  final double borderRadius;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final base = isDark ? const Color(0xFF27272A) : const Color(0xFFE4E4E7);
    final highlight = isDark ? const Color(0xFF3F3F46) : const Color(0xFFF4F4F5);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1 + 2 * _controller.value, 0),
              end: Alignment(1 + 2 * _controller.value, 0),
              colors: [base, highlight, base],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

class KpiSkeletonGrid extends StatelessWidget {
  const KpiSkeletonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: SkeletonLoader(height: 128, borderRadius: 16)),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: SkeletonLoader(height: 128, borderRadius: 16)),
          ],
        ),
        SizedBox(height: AppSpacing.sm),
        SkeletonLoader(height: 128, borderRadius: 16),
        SizedBox(height: AppSpacing.lg),
        SkeletonLoader(height: 200, borderRadius: 16),
        SizedBox(height: AppSpacing.lg),
        SkeletonLoader(height: 72, borderRadius: 16),
        SizedBox(height: AppSpacing.xs),
        SkeletonLoader(height: 72, borderRadius: 16),
      ],
    );
  }
}

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: SkeletonLoader(
            height: 76,
            borderRadius: AppSpacing.cardRadius,
          ),
        ),
      ),
    );
  }
}
