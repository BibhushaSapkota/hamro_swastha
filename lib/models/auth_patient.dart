import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Patient/login_screens.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/screens/patient_upload_profile.dart';

class LoaderScreen extends StatefulWidget {
  LoaderScreen({Key? key}) : super(key: key);

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Controller();
  }
}

class Controller extends StatefulWidget {
  Controller();
  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  _ControllerState();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loginUserModel = UserModel();
  String? id;
  var email;
  bool? isPatient;
  bool? isFormCompleted;
  String? profileUrl;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((value) {
      this.loginUserModel = UserModel.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        email = loginUserModel.email.toString();
        id = loginUserModel.uid.toString();
        isPatient = loginUserModel.isPatient;
        isFormCompleted = loginUserModel.isFormCompleted;
        profileUrl = loginUserModel.profilePicture.toString();
      });
    });
  }

  routing() {
    if (isPatient == true) {
      if (isFormCompleted == false) {
        return const PatientUploadScreen();
      } else {
        return DashboardScreen(
          id: id!,
          profileUrl: profileUrl!,
        );
      }
    } else {
      return const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    const CircularProgressIndicator();
    return routing();
  }
}
