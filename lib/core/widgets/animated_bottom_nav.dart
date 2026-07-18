import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';

class AnimatedBottomNav extends StatefulWidget {
  const AnimatedBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;

  @override
  State<AnimatedBottomNav> createState() => _AnimatedBottomNavState();
}

class _AnimatedBottomNavState extends State<AnimatedBottomNav>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _bounce = Tween<double>(begin: 1, end: 0.92).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _handleTap(int index) {
    if (index == widget.currentIndex) return;
    HapticFeedback.lightImpact();
    _bounceController.forward().then((_) => _bounceController.reverse());
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.appColors;
    final itemCount = widget.items.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: SafeArea(
        top: false,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface.withValues(alpha: 0.92)
                    : AppColors.lightSurface.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isDark
                      ? AppColors.darkBorder.withValues(alpha: 0.8)
                      : AppColors.lightBorder.withValues(alpha: 0.9),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.45)
                        : AppColors.brandPrimary.withValues(alpha: 0.08),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                    spreadRadius: -4,
                  ),
                  BoxShadow(
                    color: colors.shadow,
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xs + 2,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = constraints.maxWidth / itemCount;
                    final isRtl =
                        Directionality.of(context) == TextDirection.rtl;
                    final indicatorLeft = isRtl
                        ? constraints.maxWidth -
                            itemWidth * (widget.currentIndex + 1)
                        : itemWidth * widget.currentIndex;

                    return SizedBox(
                      height: 64,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOutCubic,
                            left: indicatorLeft + 4,
                            top: 4,
                            bottom: 4,
                            width: itemWidth - 8,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.brandPrimary
                                        .withValues(alpha: isDark ? 0.22 : 0.14),
                                    AppColors.brandPrimaryLight
                                        .withValues(alpha: isDark ? 0.12 : 0.06),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.brandPrimary
                                      .withValues(alpha: 0.2),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(itemCount, (index) {
                              final item = widget.items[index];
                              final isSelected =
                                  widget.currentIndex == index;

                              return Expanded(
                                child: _NavItem(
                                  item: item,
                                  isSelected: isSelected,
                                  bounce: isSelected ? _bounce : null,
                                  onTap: () => _handleTap(index),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.bounce,
  });

  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final Animation<double>? bounce;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: isSelected ? 40 : 36,
          height: isSelected ? 40 : 36,
          decoration: BoxDecoration(
            gradient: isSelected ? AppColors.brandGradient : null,
            color: isSelected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.brandPrimary.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            isSelected ? item.activeIcon : item.icon,
            size: isSelected ? 22 : 21,
            color: isSelected ? Colors.white : colors.textTertiary,
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: isSelected
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.brandPrimary,
                      letterSpacing: 0.2,
                    ),
                  ),
                )
              : const SizedBox(height: 0),
        ),
      ],
    );

    if (bounce != null) {
      content = AnimatedBuilder(
        animation: bounce!,
        builder: (context, child) => Transform.scale(
          scale: bounce!.value,
          child: child,
        ),
        child: content,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: AppColors.brandPrimary.withValues(alpha: 0.08),
        highlightColor: AppColors.brandPrimary.withValues(alpha: 0.04),
        child: content,
      ),
    );
  }
}

class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}
