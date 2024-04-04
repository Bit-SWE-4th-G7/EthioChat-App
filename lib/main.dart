import 'package:ethiochat/firebase_options.dart';
import 'package:ethiochat/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ethiochat/colors.dart';
import 'package:ethiochat/screens/mobile_layout_screen.dart';
import 'package:ethiochat/screens/web_layout_screen.dart';
import 'package:ethiochat/utils/responsive_layout.dart';

void main() async{
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      onGenerateRoute: ,
      home:  LandingScreen(),
    );
  }
}
