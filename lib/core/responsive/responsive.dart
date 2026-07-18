import 'package:flutter/widgets.dart';

/// Screen-size class, using Material 3's window-size breakpoints (in dp).
enum ScreenSize {
  /// Phones in portrait. < 600dp.
  compact,

  /// Large phones landscape / small tablets. 600–839dp.
  medium,

  /// Tablets and up. >= 840dp.
  expanded,
}

/// Central responsive helpers.
///
/// The app is phone-first, so the goal on larger screens is not to stretch the
/// phone layout edge to edge but to (a) cap content to a readable width and
/// (b) use the extra room for more grid columns. These helpers encode that in
/// one place so every screen behaves consistently.
class Responsive {
  const Responsive._();

  static const double mediumBreakpoint = 600;
  static const double expandedBreakpoint = 840;

  /// The widest a single column of content should ever get. Beyond this, lines
  /// become hard to read and cards look absurdly wide, so content is centered
  /// within this bound on large screens.
  static const double maxContentWidth = 640;

  static ScreenSize sizeOf(double width) {
    if (width >= expandedBreakpoint) return ScreenSize.expanded;
    if (width >= mediumBreakpoint) return ScreenSize.medium;
    return ScreenSize.compact;
  }

  /// Columns for a card/product grid at the given width.
  static int gridColumns(double width) {
    if (width >= 1200) return 4;
    if (width >= expandedBreakpoint) return 3;
    if (width >= mediumBreakpoint) return 2;
    return 1;
  }
}

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  ScreenSize get sizeClass => Responsive.sizeOf(screenWidth);

  bool get isCompact => sizeClass == ScreenSize.compact;
  bool get isMedium => sizeClass == ScreenSize.medium;
  bool get isExpanded => sizeClass == ScreenSize.expanded;

  /// True once there is enough width to justify multi-column / centered layouts.
  bool get isWide => screenWidth >= Responsive.mediumBreakpoint;

  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  /// Picks a value by size class, falling back to the next smaller one when a
  /// larger override isn't given.
  T responsive<T>({required T compact, T? medium, T? expanded}) {
    switch (sizeClass) {
      case ScreenSize.expanded:
        return expanded ?? medium ?? compact;
      case ScreenSize.medium:
        return medium ?? compact;
      case ScreenSize.compact:
        return compact;
    }
  }
}
