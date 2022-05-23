import 'package:flutter/material.dart';

class SnackMessage {
  static const snackBarFail = SnackBar(
    content: Text(
      "Login Failed",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.redAccent,
  );

  static const snackBarSucess = SnackBar(
    content: Text(
      " Login Successful.",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.green,
    duration: Duration(
      seconds: 3,
    ),
    dismissDirection: DismissDirection.down,
  );

  static const snackBarAccountSuccess = SnackBar(
    content: Text(
      "Account Created Successful.",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.green,
    duration: Duration(
      seconds: 3,
    ),
    dismissDirection: DismissDirection.down,
  );

  // static const snackBarAccountFail =
}
