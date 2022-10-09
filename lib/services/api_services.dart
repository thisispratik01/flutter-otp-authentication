import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_phone_auth/constants.dart';
import 'package:http/http.dart' as http;
import 'package:ui_phone_auth/screens/login_success/login_success_screen.dart';
import 'package:ui_phone_auth/screens/login_success/my_home.dart';
import 'package:ui_phone_auth/screens/sign_up/components/sign_up_form.dart';

import '../screens/otp/otp_screen.dart';

String uri = 'http://192.168.0.106:3000'; //http://your ip address:3000

class ApiServices {
//send phone no to generate otp route to get otp and hash

  void getOTPRegister({
    required BuildContext context,
    required int phone,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/user/get-otp-register'),
        body: jsonEncode({
          "phone": phone,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Navigator.pushNamed(context, OtpScreen.routeName, arguments: {
              "mlogin": false,
              "phone": phone,
              "password": password,
              "hash": jsonDecode(res.body)["fullhash"],
            });
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void registerApi({
    required BuildContext context,
    required int phone,
    required String password,
    required String otp,
    required String hash,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/user/register'),
        body: jsonEncode({
          "phone": phone,
          "password": password,
          "otp": otp,
          "hash": hash,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('x-token', jsonDecode(res.body)["token"]);
            Navigator.pushNamedAndRemoveUntil(
                context, MyHomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void getOtpLogin({
    required BuildContext context,
    required int phone,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/user/get-otp-login'),
        body: jsonEncode({"phone": phone}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Navigator.pushNamed(context, OtpScreen.routeName, arguments: {
              "mlogin": true,
              "phone": phone,
              "hash": jsonDecode(res.body)["fullhash"],
            });
          });

      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void loginApi({
    required BuildContext context,
    required String otp,
    required int phone,
    required String hash,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/user/login'),
        body: jsonEncode({
          "phone": phone,
          "otp": otp,
          "hash": hash,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('x-token', jsonDecode(res.body)["token"]);
            Navigator.pushNamedAndRemoveUntil(
                context, LoginSuccessScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
