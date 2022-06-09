import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mero_doctor/main.dart';
import 'package:mero_doctor/screens/choose_screen.dart';

void main() {
  testWidgets("testing ", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets("testing choosing screen ", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ChooseScreen()));
    expect(find.text("Who are you?"), findsOneWidget);
  });

  testWidgets("testing choosing screen 2 ", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ChooseScreen()));
    expect(find.text("Doctor"), findsOneWidget);
  });
}


