import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/DoctorProfile.dart';
import 'package:mero_doctor/screens/bookmark_page.dart';

import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/screens/loading.dart';
import 'package:mero_doctor/screens/location.dart';

import '../utils/capatalize.dart';

class ProfileScreenDoc extends StatefulWidget {
  ProfileScreenDoc({Key? key, required this.id, this.profilePicture})
      : super(key: key);
  String id;
  String? profilePicture;
  @override
  State<ProfileScreenDoc> createState() => _ProfileScreenDocState();
}

class _ProfileScreenDocState extends State<ProfileScreenDoc> {
  String? firstName;
  String? lastName;
  DoctorModel docModel = DoctorModel();
  String? capFirst;
  String? capLast;
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  String? certificate;

  String? identification;
  @override
  void initState() {
    super.initState();
    print(widget.id);
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.id)
        .get()
        .then((value) {
      docModel = DoctorModel.fromMap(value.data());
    }).whenComplete(() {
      setState(() {
        // profilePicture = userModel.profilePicture.toString();
        firstName = docModel.firstName.toString();
        lastName = docModel.lastName.toString();
        capFirst = capitalize(firstName!);
        capLast = capitalize(lastName!);
        certificate = docModel.licenseImageDownloadURL;
        identification = docModel.identificationImageDownloadURL;
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
                              builder: (context) => DoctorDashboardScreen()),
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
                            widget.profilePicture! != null ||
                                    widget.profilePicture != ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(150),
                                    child: Image.network(
                                      widget.profilePicture!,
                                      scale: 1.0,
                                      height: 120,
                                      width: 120,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(150),
                                    child: Image.asset(
                                      "assets/images/profile.jpg",
                                      scale: 1.0,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
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
                              InkWell(
                                child: _getCard(
                                    "My Profile", Icons.watch_later_outlined),
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => DoctorProfile(
                                                id: widget.id,
                                                profileUrl:
                                                    widget.profilePicture,
                                                certificate: certificate,
                                                identification: identification,
                                              )),
                                      (route) => false);
                                },
                              ),
                              _getCard("Notification",
                                  Icons.notifications_active_outlined),
                              InkWell(
                                child: _getCard("My Bookmark", Icons.bookmark),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Bookmarked()));
                                },
                              ),
                              InkWell(
                                child: _getCard(
                                    "Location", Icons.location_on_outlined),
                                onTap: () {
                                  setState(() {
                                    loading = true;
                                  });

                                  setState(() {
                                    Future.delayed(Duration(seconds: 3), () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => Location(
                                                    id: widget.id,
                                                    profilePicture:
                                                        widget.profilePicture,
                                                  )),
                                          (route) => false);
                                      loading = false;
                                    });
                                  });
                                },
                              ),
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
                                        builder: (context) => LoginPageDoc()),
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
