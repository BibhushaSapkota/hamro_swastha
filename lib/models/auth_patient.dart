import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Patient/login_screens.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';

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
  late String id;
  var email;
  bool? isPatient;

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
      });
    });
  }

  routing() {
    if (isPatient == true) {
      return DashboardScreen(id: id);
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
