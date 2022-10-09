import 'package:flutter/material.dart';
import 'package:ui_phone_auth/components/default_button.dart';
import 'package:ui_phone_auth/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.04,
        ),
        Center(
          child: Image.asset(
            "assets/images/success.png",
            height: SizeConfig.screenHeight * 0.4, //0.4=40%  0.04 =4%
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.08,
        ),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(text: "Back to home", press: () {}),
        ),
        Spacer(),
      ],
    );
  }
}
