import 'package:flutter/cupertino.dart';

class RouteBuilder extends PageRouteBuilder {
  Duration duration;
  Offset begin;
  Offset end;
  Curve curve;

  RouteBuilder(
      {this.duration = const Duration(milliseconds: 100),
      this.begin = const Offset(1.0, 0.0),
      this.end = Offset.zero,
      this.curve = Curves.easeOut,
      required super.pageBuilder});

  @override
  Duration get reverseTransitionDuration {
    return duration;
  }

  @override
  Duration get transitionDuration {
    return duration;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
