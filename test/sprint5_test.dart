import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mero_doctor/main.dart';
import 'package:mero_doctor/screens/splash_screen.dart';

void main() {
  testWidgets("testing material app ", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets("testing Splash Screen ", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home:SplashScreen()));

    expect(find.text("Powered by Mero Health"), findsOneWidget);
  });


}
