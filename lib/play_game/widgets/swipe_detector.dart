import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  const SwipeDetector({
    super.key,
    required this.onSwipeUp,
    required this.onSwipeDown,
    required this.onSwipeRight,
    required this.onSwipeLeft,
    required this.child,
    required this.disable,
  });
  final Function onSwipeUp;
  final Function onSwipeDown;
  final Function onSwipeRight;
  final Function onSwipeLeft;
  final Widget child;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: disable
          ? null
          : (details) => details.velocity.pixelsPerSecond.dx < 0 ? onSwipeRight() : onSwipeLeft(),
      onVerticalDragEnd: disable
          ? null
          : (details) => details.velocity.pixelsPerSecond.dy < 0 ? onSwipeUp() : onSwipeDown(),
      child: child,
    );
  }
}
