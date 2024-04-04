import 'package:ethiochat/common/error.dart';
import 'package:ethiochat/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold(
          body:const ErrorScreen(error: "This page doesn\'t exist",)
        ));
    }
  }
}
