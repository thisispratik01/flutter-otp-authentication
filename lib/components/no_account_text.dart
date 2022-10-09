import 'package:flutter/material.dart';
import 'package:ui_phone_auth/constants.dart';
import 'package:ui_phone_auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:ui_phone_auth/screens/sign_up/sign_up_screen.dart';
import 'package:ui_phone_auth/size_config.dart';

class noAccountText extends StatelessWidget {
  const noAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => SignUpScreen()));
          },
          // onTap: () {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (builder) => ForgotPasswordScreen()));
          // },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
