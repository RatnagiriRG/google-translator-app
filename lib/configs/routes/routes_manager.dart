import 'package:flutter/material.dart';
import 'package:translator/configs/routes/navigation_service.dart';
import 'package:translator/configs/routes/routes_name.dart';
import 'package:translator/feature/noInternet/view/no_internet_view.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case RoutesName.noInternetScreen:
        return CustomPageRouteSlowTransition(
          const NoInternetView(),
        );
      default:
        return CustomPageRouteSlowTransition(
          const Scaffold(
            body: SafeArea(
              child: Center(
                child: Text("Please try again later....."),
              ),
            ),
          ),
        );
    }
  }
}
