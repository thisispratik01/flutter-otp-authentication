import 'package:flutter/material.dart';
import 'package:ui_phone_auth/screens/splash/components/body.dart';
import 'package:ui_phone_auth/size_config.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
