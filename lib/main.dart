import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/screens/Choose_Authencation.dart';
import 'package:mero_doctor/screens/choose_screen.dart';
import 'package:mero_doctor/screens/login_screens.dart';
import 'package:mero_doctor/screens/register_screen.dart';
import 'package:mero_doctor/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return MaterialApp(
      routes: {
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterScreen(),
        "/auth": (context) => ChooseAuth(),
        "/": (context) => ChooseScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: COLOR_PRIMARY,
          accentColor: COLOR_SECONDARY,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
    );
  }
}
