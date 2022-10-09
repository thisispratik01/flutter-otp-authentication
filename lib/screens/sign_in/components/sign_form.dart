import 'package:flutter/material.dart';
import 'package:ui_phone_auth/components/custom_suffix_icon.dart';
import 'package:ui_phone_auth/components/default_button.dart';
import 'package:ui_phone_auth/components/form_error.dart';
import 'package:ui_phone_auth/constants.dart';
import 'package:ui_phone_auth/screens/login_success/login_success_screen.dart';
import 'package:ui_phone_auth/services/api_services.dart';
import 'package:ui_phone_auth/size_config.dart';

import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final ApiServices apiServices = ApiServices();

  String? phone;
  String? password;
  bool remember = false;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          SizedBox(
            height: getProportionateScreenHeight(22),
          ),
          // buildPasswordFormField(),
          // SizedBox(
          //   height: getProportionateScreenHeight(30),
          // ),
          // Row(
          //   children: [
          //     Checkbox(
          //         activeColor: kPrimaryColor,
          //         value: remember,
          //         onChanged: (value) {
          //           setState(() {
          //             remember = value!;
          //           });
          //         }),
          //     Text("Remember me"),
          //     Spacer(),
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (builder) => ForgotPasswordScreen()));
          //       },
          //       child: Text(
          //         "Forgot Password",
          //         style: TextStyle(decoration: TextDecoration.underline),
          //       ),
          //     ),
          //   ],
          // ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(22),
          ),
          DefaultButton(
              text: "Login",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  apiServices.getOtpLogin(
                      context: context, phone: int.parse(phone!));
                }
              }),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) {
        password = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
      },
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Enter your password",
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.isNotEmpty &&
            value.length < 8 &&
            !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
        }
        return null;
      },
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      onSaved: (newValue) {
        phone = newValue;
      },
      onChanged: (value) {
        if (errors.contains(kPhoneNullError)) {
          setState(() {
            errors.remove(kPhoneNullError);
          });
        } else if (value.length == 10 && errors.contains(kInvalidPhoneError)) {
          setState(() {
            errors.remove(kInvalidPhoneError);
          });
        }
      },
      decoration: InputDecoration(
        hintText: "Enter your phone ",
        labelText: "Phone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(12),
            getProportionateScreenWidth(20),
            0,
            getProportionateScreenWidth(20),
          ),
          child: Text(
            "+91",
            style: TextStyle(fontSize: getProportionateScreenWidth(17)),
          ),
        ),
      ),
      validator: (value) {
        //in below code if email is empty and errors list not contains that error then only call setstate and add error in errors list.
        //errors.contains() means errors list has specified value
        //!errors.contains here ! denotes not contains .
        if (value!.isEmpty && !errors.contains(kPhoneNullError)) {
          setState(() {
            errors.add(kPhoneNullError);
          });
          //emailValidatorRegExp.hasMatch(value) denotes value matched with regex.
          //!emailValidatorRegExp.hasMatch(value) here ! denotes value not matched with regex.
          //means if value not matched with regex and errors list not contains that error already then only call setstate and add error in errors list.
          //   if (!emailValidatorRegExp.hasMatch(value) &&
          //     !errors.contains(kInvalidEmailError) &&
          //     value.isNotEmpty) {
          //   setState(() {
          //     errors.add(kInvalidEmailError);
          //   });
          // }
          return "";
        } else if (value.isEmpty && errors.contains(kPhoneNullError)) {
          return "";
        } else if (value.isNotEmpty &&
            value.length != 10 &&
            !errors.contains(kInvalidPhoneError)) {
          setState(() {
            errors.add(kInvalidPhoneError);
          });

          return "";
        } else if (value.isNotEmpty &&
            value.length != 10 &&
            errors.contains(kInvalidPhoneError)) {
          return "";
        }
        return null;
      },
    );
  }
}
