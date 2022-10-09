import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_phone_auth/services/api_services.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class OtpForm extends StatefulWidget {
  final int phone;
  final bool mlogin;
  final String? password;
  final String hash;
  const OtpForm(
      {Key? key,
      required this.phone,
      this.password,
      required this.hash,
      required this.mlogin})
      : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  final ApiServices apiServices = ApiServices();

  String? num1;
  String? num2;
  String? num3;
  String? num4;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField({String? value, FocusNode? focusNode}) {
    if (value!.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Number 1
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    num1 = value;
                    if (value.length == 1) {
                      nextField(value: value, focusNode: pin2FocusNode);
                    }
                  },
                ),
              ),
              //Number 2
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  // autofocus: true,
                  focusNode: pin2FocusNode,

                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    num2 = value;
                    if (value.length == 1) {
                      nextField(value: value, focusNode: pin3FocusNode);
                    }
                  },
                ),
              ),
              //Number 3
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  // autofocus: true,
                  focusNode: pin3FocusNode,

                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    num3 = value;
                    if (value.length == 1) {
                      nextField(value: value, focusNode: pin4FocusNode);
                    }
                  },
                ),
              ),
              //Number 4
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  // autofocus: true,
                  focusNode: pin4FocusNode,
                  // maxLength: 1,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    num4 = value;
                    if (value.length == 1) {
                      pin4FocusNode!.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          DefaultButton(
              text: "Continue",
              press: () async {
                if (widget.mlogin == true) {
                  if (num1!.length == 1 &&
                      num2!.length == 1 &&
                      num3!.length == 1 &&
                      num4!.length == 1) {
                    var otp = num1! + num2! + num3! + num4!;
                    apiServices.loginApi(
                      context: context,
                      otp: otp,
                      phone: widget.phone,
                      hash: widget.hash,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All fields are required")),
                    );
                  }
                } else {
                  if (num1!.length == 1 &&
                      num2!.length == 1 &&
                      num3!.length == 1 &&
                      num4!.length == 1) {
                    var otp = num1! + num2! + num3! + num4!;

                    apiServices.registerApi(
                        context: context,
                        phone: widget.phone,
                        password: widget.password!,
                        otp: otp,
                        hash: widget.hash);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All fields are required")),
                    );
                  }
                }
              }),
        ],
      ),
    );
  }
}
