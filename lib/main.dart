import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/screens/Choose_Authencation/Choose_Authencation_patient.dart';
import 'package:mero_doctor/screens/Choose_Authencation/Choose_Authencation_doctor.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/Doctor/register_screens_doctor.dart';
import 'package:mero_doctor/screens/choose_screen.dart';
import 'package:mero_doctor/screens/Patient/login_screens.dart';
import 'package:mero_doctor/screens/Patient/register_screen.dart';
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
        "/login": (context) => const LoginPage(),
        "/register_patient": (context) => RegisterScreen(),
        "/login_doctor": (context) => const LoginPageDoc(),
        "/register_doctor": (context) => RegisterScreenDoc(),
        "/auth": (context) => const ChooseAuth(),
        "/authDoc": (context) => const ChooseAuthDoc(),
        "/": (context) => const ChooseScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: COLOR_PRIMARY,
          accentColor: COLOR_SECONDARY,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
    );
  }
}
