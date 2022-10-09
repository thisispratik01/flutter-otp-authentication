import 'package:flutter/material.dart';
import 'package:ui_phone_auth/screens/otp/otp_screen.dart';
import 'package:ui_phone_auth/services/api_services.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final ApiServices apiServices = ApiServices();

  String? phone;
  String? password;
  String? confirm_password;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildConfirmPasswordFormField(),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  apiServices.getOTPRegister(
                      context: context,
                      phone: int.parse(phone!),
                      password: password!);
                }
              }),
        ],
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) {
        confirm_password = newValue;
      },
      onChanged: (value) {
        if (password == value) {
          setState(() {
            errors.remove(kMatchPassError);
          });
        }
      },
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Re-enter your password",
        labelText: "Confirm Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please re enter password";
        } else if (value.isNotEmpty &&
            password != value &&
            !errors.contains(kMatchPassError)) {
          setState(() {
            errors.add(kMatchPassError);
          });
          return "";
        } else if (value.isNotEmpty &&
            password != value &&
            errors.contains(kMatchPassError)) {
          return "";
        }
        return null;
      },
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
        setState(() {
          password = value;
        });
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
          return "";
        } else if (value.isEmpty && errors.contains(kPassNullError)) {
          return "";
        } else if (value.isNotEmpty &&
            value.length < 8 &&
            !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return "";
        } else if (value.isNotEmpty &&
            value.length < 8 &&
            errors.contains(kShortPassError)) {
          return "";
        }
        return null;
      },
    );
  }

  // TextFormField buildEmailFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.emailAddress,
  //     onSaved: (newValue) {
  //       email = newValue;
  //     },
  //     onChanged: (value) {
  //       if (errors.contains(kEmailNullError)) {
  //         setState(() {
  //           errors.remove(kEmailNullError);
  //         });
  //       } else if (emailValidatorRegExp.hasMatch(value) &&
  //           errors.contains(kInvalidEmailError)) {
  //         setState(() {
  //           errors.remove(kInvalidEmailError);
  //         });
  //       }
  //     },
  //     decoration: const InputDecoration(
  //       hintText: "Enter your email",
  //       labelText: "Email",
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSuffixIcon(
  //         svgIcon: "assets/icons/Mail.svg",
  //       ),
  //     ),
  //     validator: (value) {
  //       //in below code if email is empty and errors list not contains that error then only call setstate and add error in errors list.
  //       //errors.contains() means errors list has specified value
  //       //!errors.contains here ! denotes not contains .
  //       if (value!.isEmpty && !errors.contains(kEmailNullError)) {
  //         setState(() {
  //           errors.add(kEmailNullError);
  //         });
  //         //emailValidatorRegExp.hasMatch(value) denotes value matched with regex.
  //         //!emailValidatorRegExp.hasMatch(value) here ! denotes value not matched with regex.
  //         //means if value not matched with regex and errors list not contains that error already then only call setstate and add error in errors list.
  //       } else if (!emailValidatorRegExp.hasMatch(value) &&
  //           !errors.contains(kInvalidEmailError) &&
  //           value.isNotEmpty) {
  //         setState(() {
  //           errors.add(kInvalidEmailError);
  //         });
  //       }
  //       return null;
  //     },
  //   );
  // }
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
