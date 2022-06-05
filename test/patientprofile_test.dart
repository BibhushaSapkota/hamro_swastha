import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mero_doctor/main.dart';
import 'package:mero_doctor/screens/patient_profile.dart';


void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  testWidgets('Profile Screen', (WidgetTester tester) async {
    await tester.pumpWidget(ProfileScreen(id: "2qTTJHYhnIahXmzC3HKV8WAet7Y2"));
    await tester.pump(const Duration(seconds: 10));
    final titleText = find.text('Profile');
    expect(titleText, findsOneWidget);
  });


 

}
