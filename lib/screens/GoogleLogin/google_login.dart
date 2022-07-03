import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    print("GoogleLogin Function Reached...........");

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    print("User ...........");
    print(_user);

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? useraccount = userCredential.user;
    print(useraccount);
    return useraccount;

    notifyListeners();
  }

  Future googleLogout() async {
    try {
      await googleSignIn.disconnect();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
