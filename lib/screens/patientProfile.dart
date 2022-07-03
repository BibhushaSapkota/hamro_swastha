import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:page_transition/page_transition.dart';

class PatientProfile extends StatefulWidget {
  String? id;
  PatientProfile({Key? key, this.id}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  String? profileUrl;
  String? oldReport;
  String? fullName;
  String? email;
  String? contactNumber;

  UserModel _userModel = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String firstName;
    String lastName;
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .get()
        .then((value) {
      _userModel = UserModel.fromMap(value.data());

      setState(() {
        firstName = _userModel.firstName!;
        lastName = _userModel.lastName!;
        email = _userModel.email;
        oldReport = _userModel.oldReportFile;
        fullName = firstName + " " + lastName;
        contactNumber = _userModel.contact;
        profileUrl = _userModel.profilePicture;
        fullName = fullName!.toUpperCase();
        print(fullName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int _indexSelected = 3;
    final screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: GNav(
          activeColor: Color(0xffd36868),
          color: Colors.black45,
          tabBackgroundColor: Color(0xFFF1EFEF),
          padding: EdgeInsets.all(16),
          gap: 10,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 400),
          tabs: [
            GButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: DashboardScreen(
                          id: widget.id!,
                          profileUrl: profileUrl,
                        ),
                        type: PageTransitionType.leftToRight));
              },
              icon: Icons.home,
              text: 'Home',
              textSize: 12,
            ),
            const GButton(
                icon: Icons.date_range_rounded, text: 'Schedule', textSize: 12),
            const GButton(
                icon: Icons.notifications_active_rounded,
                text: 'Notification',
                textSize: 12),
            GButton(
                active: true,
                onPressed: () {},
                icon: Icons.person,
                text: 'Profile',
                textSize: 12),
          ],
          selectedIndex: _indexSelected,
          onTabChange: (index) {
            _indexSelected = index;
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                Positioned(
                    child: Container(
                  width: screen.width,
                  height: screen.height / 3.5,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(90, 30),
                      bottomRight: Radius.elliptical(90, 30),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                    image: DecorationImage(
                        image: AssetImage('assets/images/bak.png'),
                        fit: BoxFit.fill),
                  ),
                )),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      profileUrl == null || profileUrl == ""
                          ? CircleAvatar(
                              backgroundColor: Colors.grey[800],
                              backgroundImage: const AssetImage(
                                  "assets/images/doctor_view.png"),
                              radius: 60,
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey[800],
                              backgroundImage: NetworkImage("$profileUrl"),
                              radius: 80,
                            ),
                      Divider(),
                      fullName == null || fullName == ""
                          ? const Text(
                              "",
                              style: TextStyle(color: Colors.black),
                            )
                          : Text(
                              "$fullName",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  tooltip: 'Back button',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                                  id: widget.id!,
                                  profileUrl: profileUrl,
                                )),
                        (route) => false);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Email: ",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                      ),
                      email == "" || email == null
                          ? const Text("",
                              style: TextStyle(
                                fontSize: 14,
                              ))
                          : Text(
                              "$email",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Contact: ",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                      ),
                      contactNumber == "" || contactNumber == null
                          ? Text(
                              "",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 14,
                              )),
                            )
                          : Text(
                              "$contactNumber",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Report: ",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
