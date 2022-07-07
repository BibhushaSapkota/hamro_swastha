import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/auth_doctor.dart';
import 'package:mero_doctor/models/auth_patient.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/screens/doctor_upload_info.dart';

class AuthUser extends StatefulWidget {
  const AuthUser();
  @override
  State<AuthUser> createState() => _AuthUserState();
}

class _AuthUserState extends State<AuthUser> {
  User? user = FirebaseAuth.instance.currentUser;
  DoctorModel doctorModel = DoctorModel();
  UserModel userModel = UserModel();
  bool? isDoctor = false;
  bool? isPatient = false;

  @override
  void initState() {
    super.initState();
    getDoctor();
    getPatient();
  }

  getDoctor() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(user!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        doctorModel = DoctorModel.fromMap(value.data());
      }
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        isDoctor = doctorModel.isDoctor;
      });
    });
  }

  getPatient() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        userModel = UserModel.fromMap(value.data());
      }
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        isPatient = userModel.isPatient;
      });
    });
  }

  routeDoc() {
    if (isDoctor == true) {
      return const LoadingScreenDoc();
    } else if (isPatient = true) {
      return const LoaderScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    const CircularProgressIndicator();
    return routeDoc();
  }
}
