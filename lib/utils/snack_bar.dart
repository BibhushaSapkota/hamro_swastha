import 'package:flutter/material.dart';

class SnackMessage {
  static successSnackBar(String message) => SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.green,
    duration: const Duration(
      seconds: 3,
    ),
    dismissDirection: DismissDirection.down,
  );

  static errorSnackBar(String message) => SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(
      seconds: 3,
    ),
    dismissDirection: DismissDirection.down,
  );
}
