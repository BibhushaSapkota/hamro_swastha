import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import 'package:mero_doctor/main.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';

void main() {
  testWidgets("dashboard testing", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScreen(),
    ));
    expect(find.text("Categories"), findsOneWidget);
  });

  testWidgets("given text not found", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScreen(),
    ));
    expect(find.text("Cat"), findsNothing);
  });
  
  testWidgets("textfield testing", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScreen(),
    ));
    final tfwidget = find.byKey(ValueKey("search"));
    await tester.enterText(tfwidget, "ffff");
    expect(find.text("ffff"), findsOneWidget);
  });

    testWidgets("icon testing", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScreen(),
    ));
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });

}
