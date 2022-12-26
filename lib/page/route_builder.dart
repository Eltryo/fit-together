import 'package:flutter/material.dart';

class RouteBuilder {
  final Widget widget;
  final Duration duration;
  final Offset begin;
  final Offset end;
  final Curve curve;

  RouteBuilder({
    this.duration = const Duration(milliseconds: 100),
    this.begin = const Offset(1.0, 0.0),
    this.end = Offset.zero,
    this.curve = Curves.easeOut,
    required this.widget,
  });

  Route buildRoute() {
    return PageRouteBuilder(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
