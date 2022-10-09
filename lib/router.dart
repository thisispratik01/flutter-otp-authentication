import 'package:flutter/material.dart';
import 'package:ui_phone_auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:ui_phone_auth/screens/login_success/login_success_screen.dart';
import 'package:ui_phone_auth/screens/login_success/my_home.dart';
import 'package:ui_phone_auth/screens/otp/otp_screen.dart';

import 'package:ui_phone_auth/screens/sign_in/sign_in_screen.dart';
import 'package:ui_phone_auth/screens/sign_up/sign_up_screen.dart';
import 'package:ui_phone_auth/screens/splash/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SplashScreen(),
      );

    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SignUpScreen(),
      );

    case SignInScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SignInScreen(),
      );

    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ForgotPasswordScreen(),
      );

    case LoginSuccessScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => LoginSuccessScreen(),
      );

    case OtpScreen.routeName:
      var args = routeSettings.arguments as Map;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => args["mlogin"]
            ? OtpScreen(
                phone: args["phone"],
                hash: args['hash'],
                mlogin: args["mlogin"],
              )
            : OtpScreen(
                phone: args["phone"],
                password: args['password'],
                hash: args['hash'],
                mlogin: args["mlogin"],
              ),
      );

    case MyHomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const MyHomeScreen());

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Text("Screen doesnt exists."));
  }
}
