import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class CustomPageRouteSlowTransition<T> extends PageRoute<T> {
  CustomPageRouteSlowTransition(
    this.child,
  );
  var brightness = SchedulerBinding.instance.window.platformBrightness;

  @override
  Color get barrierColor =>
      brightness == Brightness.dark ? Colors.black : Colors.white;

  @override
  String get barrierLabel => "";

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);
}

class CustomPageRouteFastTransition<T> extends PageRoute<T> {
  CustomPageRouteFastTransition(
    this.child,
  );
  var brightness = SchedulerBinding.instance.window.platformBrightness;

  @override
  Color get barrierColor =>
      brightness == Brightness.dark ? Colors.black : Colors.white;

  @override
  String get barrierLabel => "";

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
