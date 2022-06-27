import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mero_doctor/main.dart' as app;

void main() {
  group('App test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('full app test', (tester) async {
      app.main();
      tester.pumpAndSettle();
      final emailFormField = find.byType(TextFormField).first;
      final passwordFormField = find.byType(TextFormField).last;
      final loginButton = find.byType(MaterialButton);
    });
  });
}
