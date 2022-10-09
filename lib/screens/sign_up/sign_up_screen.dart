import 'package:flutter/material.dart';
import 'package:ui_phone_auth/screens/sign_up/components/body.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign_up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: Body()),
    );
  }
}
