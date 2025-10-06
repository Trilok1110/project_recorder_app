import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final AxisDirection direction;
  final Duration duration;
  final Curve curve;

  SlidePageRoute({
    required this.page,
    this.direction = AxisDirection.left, // default move in from left
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
  }) : super(
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final beginOffset = switch (direction) {
        AxisDirection.left => const Offset(1.0, 0.0),
        AxisDirection.right => const Offset(-1.0, 0.0),
        AxisDirection.up => const Offset(0.0, 1.0),
        AxisDirection.down => const Offset(0.0, -1.0),
      };
      final offsetAnimation = Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      ));
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
