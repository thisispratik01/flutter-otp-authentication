import 'package:flutter/material.dart';
import 'package:ui_phone_auth/screens/login_success/components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static const String routeName = '/success';
  const LoginSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Success",
        ),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
