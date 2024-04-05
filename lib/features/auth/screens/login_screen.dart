import 'package:country_picker/country_picker.dart';
import 'package:ethiochat/colors.dart';
import 'package:ethiochat/common/utils/utils.dart';
import 'package:ethiochat/common/widgets/custom_button.dart';
import 'package:ethiochat/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text;
    if(country != null && phoneNumber.isNotEmpty){
      ref
      .read(authControllerProvider)
      .signInWithPhone(context, "+${country!.phoneCode}${phoneNumber}");
    }else{
      showSnackBar(context: context, content: "Please enter a valid phone number");
    
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Ethiochat will need verify your phone number."),
              const SizedBox(
                height: 10,
              ),
              TextButton(onPressed: pickCountry, child: Text("Pick Country")),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  if (country != null) Text("+${country!.phoneCode}"),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(hintText: "Phone number"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.55,
              ),
              SizedBox(
                width: 90,
                child: CustomButton(
                  onPressed:sendPhoneNumber,
                  text: 'NEXT',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
