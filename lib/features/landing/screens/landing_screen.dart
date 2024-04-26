import 'package:ethiochat/colors.dart';
import 'package:ethiochat/common/widgets/custom_button.dart';
import 'package:ethiochat/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Welcome to EthioChat",
          style: TextStyle(
              fontSize: 33, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(height: size.height / 9),
        Image.asset(
          "assets/bg.png",
          height: 240,
          width: 240,
        ),
        SizedBox(height: size.height / 12),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "Read our Privacy Policy. Tap 'Agree and continue' to accept the Terms of Service.",
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
            width: size.width * 0.75,
            child: CustomButton(
              text: "Agree and Continue",
              onPressed: () => navigateToLoginScreen(context),
            ))
      ],
    )));
  }
}
