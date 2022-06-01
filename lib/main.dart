import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/screens/Choose_Authencation/Choose_Authencation_doctor.dart';
import 'package:mero_doctor/screens/Choose_Authencation/Choose_Authencation_patient.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/Doctor/register_screens_doctor.dart';
import 'package:mero_doctor/screens/Patient/login_screens.dart';
import 'package:mero_doctor/screens/Patient/register_screen.dart';
import 'package:mero_doctor/screens/choose_screen.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/screens/doctor_list_screen.dart';
import 'package:mero_doctor/screens/doctor_profile_screen.dart';
import 'package:mero_doctor/screens/patientDetails.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/screens/doctor_upload_info.dart';
import 'package:mero_doctor/screens/patient_profile.dart';
import 'package:mero_doctor/screens/patient_upload_profile.dart';
import 'package:mero_doctor/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA16vBUjIFFKU21E4lD0G1sO1Sl30gQi9g",
      appId: "1:163614653086:android:2c15337c47bbc249a0598f",
      messagingSenderId: "XXX",
      projectId: "merodocto",
    ),
  );
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
        "/register": (context) => RegisterScreen(),
        "/register_doctor": (context) => RegisterScreenDoc(),
        "/register_patient": (context) => RegisterScreen(),
        "/authDoc": (context) => const ChooseAuthDoc(),
        "/auth": (context) => const ChooseAuth(),
        "/": (context) => const ChooseScreen(),
        "/login_doctor": (context) => const LoginPageDoc(),
        "/doctorlist": (context) => const DoctorListScreen(),
        "/profile": (context) => ProfileScreen(
              id: '',
            ),
        "/dashboard_screen": (context) => DashboardScreen(
              id: '',
            ),
        "/profile_form": (context) => ReportScreen(),
        "/logindoc": (context) => const LoginPage(),
        "/doctorprofile": (context) => const DoctorProfileScreen(),
        "/auth": (context) => ChooseAuth(),
        "/choose": (context) => ChooseScreen(),
        "/doctor_dashboard": (context) => DoctorDashboardScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: COLOR_PRIMARY,
          accentColor: COLOR_SECONDARY,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
    );
  }
}
