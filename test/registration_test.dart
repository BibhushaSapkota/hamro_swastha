import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mero_doctor/screens/register_screen.dart';

void main() {
  test('empty email returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Email should not be empty');
  });

  test('empty email ', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Email should  be empty');
  });
  test('empty password returns error string', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Password should not be empty');
  });

  test('empty password', () {
    var result = PasswordFieldValidator.validate('avjk');
    expect(result, 'Password must be 6 character or more');
  });
}
