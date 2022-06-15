import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/screens/Choose_Authencation/Choose_Authencation_doctor.dart';
import 'package:mero_doctor/screens/Choose_Authencation/Choose_Authencation_patient.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/Doctor/register_screens_doctor.dart';
import 'package:mero_doctor/screens/GoogleLogin/google_login.dart';
import 'package:mero_doctor/screens/Patient/login_screens.dart';
import 'package:mero_doctor/screens/Patient/register_screen.dart';
import 'package:mero_doctor/screens/calender_screen.dart';
import 'package:mero_doctor/screens/choose_screen.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/screens/doctorView.dart';
import 'package:mero_doctor/screens/doctor_list_screen.dart';
import 'package:mero_doctor/screens/doctor_profile_screen.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/screens/doctor_upload_info.dart';
import 'package:mero_doctor/screens/forgetpass_screen.dart';
import 'package:mero_doctor/screens/otp_screen.dart';
import 'package:mero_doctor/screens/patient_profile.dart';
import 'package:mero_doctor/screens/patient_upload_profile.dart';
import 'package:mero_doctor/screens/splash_screen.dart';
import 'package:mero_doctor/screens/userHistory.dart';
import 'package:mero_doctor/screens/walkthrough_screens.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => GoogleLogInProvider(),
      child: MaterialApp(
        routes: {
          "/login": (context) => const LoginPage(),
          "/register": (context) => const RegisterScreen(),
          "/register_doctor": (context) => RegisterScreenDoc(),
          "/register_patient": (context) => const RegisterScreen(),
          "/authDoc": (context) => const ChooseAuthDoc(),
          "/auth": (context) => const ChooseAuth(),
          "/choose_option": (context) => const ChooseScreen(),
          "/login_doctor": (context) => const LoginPageDoc(),
          "/doctorlist": (context) => DoctorListScreen(),
          "/profile": (context) => ProfileScreen(
                id: '',
              ),
          "/dashboard_screen": (context) => DashboardScreen(
                id: '',
              ),
          // '/': (context) => EnterOtpPage(),
          // "/": (context) => EnterEmailPage(),
          '/': (context) => SplashScreen(),
          '/walkthrough': (context) => const WalkthroughScreen(),
          "/profile_form": (context) => const PatientUploadScreen(),
          "/doctor_form": (context) => const DoctorFormScreen(),
          "/logindoc": (context) => const LoginPage(),
          "/doctorprofile": (context) => const DoctorProfileScreen(),
          "/doctor_dashboard": (context) => const DoctorDashboardScreen(),
          "/forgetpass": (context) => EnterEmailPage(),
          "/sendotp": (context) => EnterOtpPage(),
          '/docorview': (context) => const doctorView(),
          '/userhistory': (context) => userHistory(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: COLOR_PRIMARY,
            accentColor: COLOR_SECONDARY,
            textTheme:
                screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
      ),
    );
  }
}
