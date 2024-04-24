import 'package:crypto_now/presenter/view/create_account_view.dart';
import 'package:crypto_now/presenter/view/home_view.dart';
import 'package:crypto_now/presenter/view/initial_view.dart';
import 'package:crypto_now/presenter/view/login_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initial = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
}

class GenerateRoutes {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => InitialView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => CreateAccountView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text("View Not Found"),
        ),
      ),
    );
  }
}
