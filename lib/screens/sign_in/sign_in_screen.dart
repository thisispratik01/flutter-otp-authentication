import 'package:flutter/material.dart';
import 'package:ui_phone_auth/screens/sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/sign_in';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign In"),
      ),
      body: SingleChildScrollView(child: const Body()),
    );
  }
}
