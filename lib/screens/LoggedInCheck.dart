import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/authUser.dart';
import 'package:mero_doctor/screens/choose_screen.dart';
import 'package:mero_doctor/screens/walkthrough_screens.dart';

class Authprovider extends StatelessWidget {
  const Authprovider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else if (snapshot.hasData) {
            return const AuthUser();
            // return const Call();
          } else {
            return const WalkthroughScreen();
          }
        },
      ),
    );
  }
}
