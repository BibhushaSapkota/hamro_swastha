import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mero_doctor/main.dart';
import 'package:mero_doctor/screens/forgetpass_screen.dart';

void main() {
  testWidgets("forget password testing ", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EnterEmailPage()));
    expect(find.text("Reset Password"), findsOneWidget);
  });
}

