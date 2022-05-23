import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/Doctor/register_screens_doctor.dart';

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
      });
    });
  }

  routeDoc() {
    if (isDoctor == true) {
      return RegisterScreenDoc();
    } else {
      return const LoginPageDoc();
    }
  }

  @override
  Widget build(BuildContext context) {
    return routeDoc();
  }
}
