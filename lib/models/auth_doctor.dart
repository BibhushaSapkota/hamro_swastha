import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/Doctor/register_screens_doctor.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/screens/doctor_list_screen.dart';
import 'package:mero_doctor/screens/doctor_upload_info.dart';
import 'package:mero_doctor/utils/snack_bar.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';

class LoadingScreenDoc extends StatefulWidget {
  LoadingScreenDoc({Key? key}) : super(key: key);

  @override
  State<LoadingScreenDoc> createState() => _LoadingScreenDocState();
}

class _LoadingScreenDocState extends State<LoadingScreenDoc> {
  @override
  Widget build(BuildContext context) {
    return ControllerDoc();
  }
}

class ControllerDoc extends StatefulWidget {
  ControllerDoc();
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
      this.userModel = DoctorModel.fromMap(value.data());
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
        return DoctorListScreen();
        // return const DoctorDashboardScreen();
        // return DashboardScreen(id: id);
      } else {
        return DoctorFormScreen();
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
