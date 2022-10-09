import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ui_phone_auth/components/custom_suffix_icon.dart';
import 'package:ui_phone_auth/components/default_button.dart';
import 'package:ui_phone_auth/components/form_error.dart';
import 'package:ui_phone_auth/components/no_account_text.dart';
import 'package:ui_phone_auth/components/social_card.dart';
import 'package:ui_phone_auth/constants.dart';
import 'package:ui_phone_auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:ui_phone_auth/screens/sign_in/components/sign_form.dart';

import 'package:ui_phone_auth/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(21)),
        child: Column(
          children: [
            // SizedBox(height: SizeConfig.screenHeight * 0.01),
            Text(
              "Welcome Back",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Sign in with your email and password \nor continue with social media",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.08,
            ),
            SignForm(),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            noAccountText(),
            SizedBox(
              height: getProportionateScreenHeight(22),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialCard(icon: "assets/icons/google-icon.svg", press: () {}),
                SocialCard(icon: "assets/icons/facebook-2.svg", press: () {}),
                SocialCard(icon: "assets/icons/twitter.svg", press: () {}),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
