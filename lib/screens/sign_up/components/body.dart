import 'package:flutter/material.dart';
import 'package:ui_phone_auth/components/custom_suffix_icon.dart';
import 'package:ui_phone_auth/components/default_button.dart';
import 'package:ui_phone_auth/components/form_error.dart';
import 'package:ui_phone_auth/constants.dart';
import 'package:ui_phone_auth/screens/sign_up/components/sign_up_form.dart';
import 'package:ui_phone_auth/size_config.dart';

import '../../../components/social_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ), //1% of total screen height
            Text(
              "Register Account",
              style: headingStyle,
            ),
            Text(
              "Complete your details or continue \nwith social media",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ), //4%
            SignUpForm(),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ), //4%
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialCard(icon: "assets/icons/google-icon.svg", press: () {}),
                SocialCard(icon: "assets/icons/facebook-2.svg", press: () {}),
                SocialCard(icon: "assets/icons/twitter.svg", press: () {}),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ), //2%
            Text(
              "By continuing you confirm that you agree \nwith our Terms and Conditions",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
