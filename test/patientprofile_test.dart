import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mero_doctor/main.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/patient_profile.dart';

// void main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   testWidgets('Profile Screen', (WidgetTester tester) async {
//     await tester.pumpWidget(ProfileScreen(id: "2qTTJHYhnIahXmzC3HKV8WAet7Y2"));
//     await tester.pump(const Duration(seconds: 10));
//     final titleText = find.text('Profile');
//     expect(titleText, findsOneWidget);
//   });
// }

// void main() {
//   group('patientmodeltest', () {
//     group('initialise - ', () {
//       test('when called should check has user', () async {
//         var model = UserModel();

//         verify(sharedPreferences.hasUser);
//       });
//     });
//   });
// }

// class Mockuser extends Mock implements User {}

// class MockFirebaseauth extends Mock implements FirebaseAuth {
//   @override
//   Stream<User?> authStateChanges() {
//     return Stream.fromIterable({Mockuser()});
//   }
// }

// void main() {
//   final MockFirebaseauth mockauth = MockFirebaseauth();
//   final Auth auth = Auth(auth = MockFirebaseauth());
//   setUp(() {});

//   tearDown(() {});

//   test('emit occurs', () async {});
// }


