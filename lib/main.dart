import 'package:flutter/material.dart';
import 'package:ui_phone_auth/router.dart';

import 'package:ui_phone_auth/screens/splash/splash_screen.dart';
import 'package:ui_phone_auth/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const SplashScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
