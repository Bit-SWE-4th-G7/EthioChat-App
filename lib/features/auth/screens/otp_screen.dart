import 'package:ethiochat/colors.dart';
import 'package:ethiochat/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;

  const OTPScreen({super.key, required this.verificationId});

 void verifyOTP(WidgetRef ref,BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
      context,
      verificationId,
      userOTP,
    );
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifiying Your Number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
       body: Column(
         children: [
           const SizedBox(height: 20),
           const Text('We have sent an SMS with a code.'),
           SizedBox(
            width: size.width * 0.5,
            child:  TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '_ _ _ _ _ _ ',
                hintStyle: TextStyle(
                  fontSize: 30,
                  letterSpacing: 20,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                if(val.length == 6){
                  verifyOTP(ref, context, val.trim());
                }
              },
            ),
           ),
           const SizedBox(height: 20),
           ElevatedButton(
             onPressed: () {},
             child: const Text('Verify'),
           ),
         ],
       )
    );
  }
  
}