import 'package:ethiochat/common/error.dart';
import 'package:ethiochat/features/auth/screens/login_screen.dart';
import 'package:ethiochat/features/auth/screens/otp_screen.dart';
import 'package:ethiochat/features/auth/screens/user_information_screen.dart';
import 'package:ethiochat/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case OTPScreen.routeName:
        final verificationId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => OTPScreen(
            verificationId: verificationId,
          ),
        );
        case UserInformationScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => UserInformationScreen(),
        );
        case SelectContactsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) =>  SelectContactsScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold(
          body:const ErrorScreen(error: "This page doesn\'t exist",)
        ));
    }
  }
}
