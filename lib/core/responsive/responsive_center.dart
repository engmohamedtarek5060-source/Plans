import 'package:flutter/widgets.dart';
import 'package:saudiaaaa/core/responsive/responsive.dart';

/// Constrains its child to a readable maximum width and centers it.
///
/// On phones this is a no-op (the child already fills the width); on tablets
/// and landscape it stops content from stretching edge to edge. Drop it around
/// a screen's scrollable body so every screen gets the same treatment.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = Responsive.maxContentWidth,
    this.heightFactor,
  });

  final Widget child;
  final double maxWidth;

  /// Pass `1.0` when the parent gives loose (unbounded) vertical constraints —
  /// e.g. a `bottomNavigationBar` slot — so the [Align] sizes to the child's
  /// height instead of expanding to fill the screen. Leave null inside an
  /// `Expanded`/bounded parent, where filling the height is what you want.
  final double? heightFactor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: heightFactor,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
