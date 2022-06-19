import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mero_doctor/main.dart';
import 'package:mero_doctor/screens/forgetpass_screen.dart';
import 'package:mero_doctor/screens/otp_screen.dart';

void main() {
  testWidgets("forget password testing ", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EnterEmailPage()));
    expect(find.text("Reset Password"), findsOneWidget);
  });

   testWidgets("forget password testing 2 ", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EnterEmailPage()));
    expect(find.text("SEND OTP"), findsOneWidget);
  });

   testWidgets("OTP page testing", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EnterOtpPage()));
    expect(find.text("Please! Enter your OTP number"), findsOneWidget);
  });
  
  testWidgets("OTP page testing 2", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EnterOtpPage()));
    expect(find.text("We have sent an OTP to your email"), findsOneWidget);
  });

  
}
