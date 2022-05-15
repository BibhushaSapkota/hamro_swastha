import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mero_doctor/screens/login_screens.dart';
import 'package:mero_doctor/utils/constants.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return MaterialApp(
      routes: {
        "/":(context) => LoginPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: COLOR_PRIMARY,
          accentColor: COLOR_SECONDARY,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
    );
  }
}
