import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:mero_doctor/screens/Choose_Authencation/Choose_Authencation_doctor.dart';
import 'package:mero_doctor/screens/Choose_Authencation/Choose_Authencation_patient.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/Doctor/register_screens_doctor.dart';
import 'package:mero_doctor/screens/GoogleLogin/google_login.dart';
import 'package:mero_doctor/screens/LoggedInCheck.dart';
import 'package:mero_doctor/screens/Patient/login_screens.dart';
import 'package:mero_doctor/screens/Patient/register_screen.dart';
import 'package:mero_doctor/screens/choose_screen.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/screens/doctor_list_screen.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/screens/doctor_upload_info.dart';
import 'package:mero_doctor/screens/forgetpass_screen.dart';
import 'package:mero_doctor/screens/location.dart';
import 'package:mero_doctor/screens/otp_screen.dart';
import 'package:mero_doctor/screens/patientProfile.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleLogInProvider()),
      ],
      child: KhaltiScope(
          publicKey: 'test_public_key_2ee3f8daa2844fbb9681b6c45ebffb05',
          builder: (context, navigatorKey) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              routes: {
                // "/": (context) => const LoginPage(),
                "/register": (context) => const RegisterScreen(),
                "/register_doctor": (context) => RegisterScreenDoc(),
                "/register_patient": (context) => const RegisterScreen(),
                "/authDoc": (context) => const ChooseAuthDoc(),
                "/auth": (context) => const ChooseAuth(),
                "/choose_option": (context) => const ChooseScreen(),
                // "/choose_option": (context) => const ChooseScreen(),
                "/login_doctor": (context) => const LoginPageDoc(),
                "/doctorlist": (context) => const DoctorListScreen(),
                "/profile": (context) => ProfileScreen(
                      id: '',
                    ),
                "/dashboard": (context) => DashboardScreen(
                      id: '',
                    ),
                '/patientprofile': (context) => PatientProfile(),
                // "/": (context) => EnterEmailPage(),
                // '/': (context) => Location(),
                '/': (context) => SplashScreen(),
                "/profile_form": (context) => const PatientUploadScreen(),
                "/doctor_form": (context) => const DoctorFormScreen(),
                "/login": (context) => const LoginPage(),
                // "/doctorprofile": (context) => DoctorProfileScreen(),
                "/doctor_dashboard": (context) => const DoctorDashboardScreen(),
                "/forgetpass": (context) => const EnterEmailPage(),
                "/sendotp": (context) => EnterOtpPage(),
                '/userhistory': (context) => DoctorHistoryScreen(),
                // '/': (context) => const PaymentScreen(),
                // '/payment_screen': (context) => KhaltiPaymentPage()
                // '/': (context) => DoctorCategoryScreen(),
              },
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: COLOR_PRIMARY,
                  textTheme:
                      screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
                  colorScheme: ColorScheme.fromSwatch()
                      .copyWith(secondary: COLOR_SECONDARY)),
            );
          }),
    );
  }
}
