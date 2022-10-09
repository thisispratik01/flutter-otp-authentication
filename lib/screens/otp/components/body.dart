import 'package:flutter/material.dart';
import 'package:ui_phone_auth/components/default_button.dart';
import 'package:ui_phone_auth/constants.dart';
import 'package:ui_phone_auth/screens/otp/components/otp-form.dart';
import 'package:ui_phone_auth/size_config.dart';

class Body extends StatelessWidget {
  final int phone;
  final bool mlogin;
  final String? password;
  final String hash;
  const Body(
      {Key? key,
      required this.phone,
      this.password,
      required this.hash,
      required this.mlogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            Text(
              "OTP Verification",
              style: headingStyle,
            ),
            const Text(
              "We sent your code to registered number",
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "This code will be expired in 5 min",
                  textAlign: TextAlign.center,
                ),
                // Expanded(
                //   child: TweenAnimationBuilder(
                //     tween: Tween(begin: 5.0, end: 0),
                //     duration: Duration(minutes: 5),
                //     builder: (context, value, child) => Text(
                //       "${(value)}",
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            mlogin
                ? OtpForm(phone: phone, hash: hash, mlogin: mlogin)
                : OtpForm(
                    password: password,
                    phone: phone,
                    hash: hash,
                    mlogin: mlogin,
                  ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ), //10% of screen height
            GestureDetector(
              onTap: () {},
              child: const Text(
                "Resend OTP code",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
