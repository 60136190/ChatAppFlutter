import 'package:flutter/material.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> push(Widget child, {dynamic arguments}) {
    return navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => child));
  }

  void pop([dynamic arguments]) {
    return navigatorKey.currentState.pop(arguments);
  }
}
