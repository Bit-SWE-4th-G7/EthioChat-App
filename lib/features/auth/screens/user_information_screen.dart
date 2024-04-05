

import 'package:flutter/material.dart';

class UserInformationScreen extends StatelessWidget {
  static const routeName = '/user-information';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(""),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo))
                ],
              )
            ],
          ),
          )),
    );
  }
}