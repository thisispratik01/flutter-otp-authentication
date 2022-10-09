import 'package:flutter/material.dart';
import 'package:ui_phone_auth/screens/otp/components/body.dart';

class OtpScreen extends StatelessWidget {
  static const String routeName = '/otp_screen';

  final int phone;
  final bool mlogin;
  final String? password;
  final String hash;
  const OtpScreen(
      {Key? key,
      required this.phone,
      this.password,
      required this.hash,
      required this.mlogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: mlogin
              ? Body(
                  phone: phone,
                  hash: hash,
                  mlogin: mlogin,
                )
              : Body(
                  phone: phone,
                  password: password!,
                  hash: hash,
                  mlogin: mlogin,
                )),
    );
  }
}
