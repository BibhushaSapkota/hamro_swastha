import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/screens/doctor_upload_info.dart';

class LoadingScreenDoc extends StatefulWidget {
  const LoadingScreenDoc({Key? key}) : super(key: key);

  @override
  State<LoadingScreenDoc> createState() => _LoadingScreenDocState();
}

class _LoadingScreenDocState extends State<LoadingScreenDoc> {
  @override
  Widget build(BuildContext context) {
    return const ControllerDoc();
  }
}

class ControllerDoc extends StatefulWidget {
  const ControllerDoc();
  @override
  State<ControllerDoc> createState() => _ControllerDocState();
}

class _ControllerDocState extends State<ControllerDoc> {
  _ControllerDocState();
  User? user = FirebaseAuth.instance.currentUser;
  DoctorModel userModel = DoctorModel();
  var id;
  var email;
  bool? isDoctor;
  bool? isFormCompleted;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(user!.uid)
        .get()
        .then((value) {
      userModel = DoctorModel.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        email = userModel.email.toString();
        id = userModel.docid.toString();
        isDoctor = userModel.isDoctor;
        isFormCompleted = userModel.isFormCompleted;
      });
    });
  }

  routeDoc() {
    if (isDoctor == true) {
      if (isFormCompleted == true) {
        // return DoctorListScreen();
        return const DoctorDashboardScreen();
        // return DashboardScreen(id: id);
      } else {
        return const DoctorFormScreen();
      }
    } else {
      return const LoginPageDoc();
    }
  }

  @override
  Widget build(BuildContext context) {
    const CircularProgressIndicator();
    return routeDoc();
  }
}
