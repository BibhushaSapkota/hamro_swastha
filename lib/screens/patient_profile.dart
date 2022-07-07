import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Patient/login_screens.dart';
import 'package:mero_doctor/screens/bookmark_page.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/screens/loading.dart';

import '../utils/capatalize.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.id, this.profilePicture})
      : super(key: key);
  String id;
  String? profilePicture;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState(id, profilePicture);
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState(this.id, this.profilePicture);
  String? firstName;
  String? lastName;
  String id;
  String? profilePicture;
  UserModel userModel = UserModel();
  String? capFirst;
  String? capLast;
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    print(id);
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      userModel = UserModel.fromMap(value.data());
    }).whenComplete(() {
      setState(() {
        // profilePicture = userModel.profilePicture.toString();
        firstName = userModel.firstName.toString();
        lastName = userModel.lastName.toString();
        capFirst = capitalize(firstName!);
        capLast = capitalize(lastName!);
      });
    });
    // FirebaseFirestore.instance.collection('users').doc(id);
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    const Color primary = Color.fromRGBO(118, 181, 197, 1.0);
    const Color textColor = Color(0xff464646);
    return SafeArea(
        child: loading
            ? const Loading()
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen(
                                    id: id,
                                    profileUrl: profilePicture,
                                  )),
                          (route) => false);
                    },
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    "Profile",
                  ),
                  foregroundColor: Colors.black,
                  centerTitle: true,
                ),
                body: SizedBox(
                  height: screen.height,
                  width: screen.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Stack(
                        //   children: [
                        //     CardIconButton(Icons.arrow_back),
                        //     Container(
                        //       height: 40,
                        //       child: Center(
                        //         child: Text(
                        //           "Profile",
                        //           style: TextStyle(
                        //             color: textColor,
                        //             fontSize: 22,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            _makeCircle(200),
                            _makeCircle(170),
                            _makeCircle(140),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Image.network(
                                profilePicture!,
                                scale: 1.0,
                                height: 120,
                                width: 120,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "$capFirst $capLast",
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              _getCard("Privacy & Setting", Icons.lock_outline),
                              _getCard("Notification",
                                  Icons.notifications_active_outlined),
                              _getCard("My Prescription",
                                  Icons.medical_services_outlined),
                              InkWell(
                                child: _getCard("My Bookmark", Icons.bookmark),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Bookmarked()));
                                },
                              ),
                              _getCard("My Appointment", Icons.app_blocking),
                              _getCard("History", Icons.watch_later_outlined),
                              _getCard("Location", Icons.location_on_outlined),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              loading = true;
                              Future.delayed(Duration(seconds: 3), () {
                                loading = false;
                                _auth.signOut();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Log Out Successful!",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.white),
                                        fontSize: 14),
                                  ),
                                  backgroundColor: Colors.green,
                                ));
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (route) => false);
                              });
                            });
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 160,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primary.withAlpha(40),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.logout,
                                    size: 25,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Sign Out",
                                    style:
                                        TextStyle(color: primary, fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }

  Widget _makeCircle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          border: Border.all(
            width: 2,
            color: const Color.fromRGBO(118, 181, 197, 0.3),
          )),
    );
  }

  Widget _getCard(String text, IconData icon) {
    const Color color = Color.fromRGBO(118, 181, 197, 1.0);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: color.withAlpha(40),
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff464646),
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}
