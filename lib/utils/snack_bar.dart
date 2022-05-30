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

// Identification File
  static const snackBarIdentificationFail = SnackBar(
    content: Text(
      "Doctor Identification file is required!",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
    duration: Duration(
      seconds: 3,
    ),
    dismissDirection: DismissDirection.down,
  );

// License File
  static const snackBarLicenseFail = SnackBar(
    content: Text(
      "Doctor License file is required!",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
    duration: Duration(
      seconds: 3,
    ),
    dismissDirection: DismissDirection.down,
  );

// Doctor Specialization
  static const snackBarSpecializationFail = SnackBar(
    content: Text(
      "Doctor Specialization is required!",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
    duration: Duration(
      seconds: 3,
    ),
    dismissDirection: DismissDirection.down,
  );

// Doctor Position
  static const snackBarPositionFail = SnackBar(
    content: Text(
      "Doctor Post is required!",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
    duration: Duration(
      seconds: 3,
    ),
    dismissDirection: DismissDirection.down,
  );
}
