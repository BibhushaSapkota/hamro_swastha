import 'dart:math';
import 'package:mero_doctor/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

class PatientProfile extends StatefulWidget {
  String? id;
  String? oldReport;

  PatientProfile({Key? key, this.id, this.oldReport}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  String? profileUrl;
  bool downloading = false;
  String? fullName;
  String? email;
  String? contactNumber;
  static final Random random = Random();
  bool loading = false;

  UserModel _userModel = UserModel();
  Dio dio = Dio();
  var progress = "";

  void startDownloading() async {
    loading = false;

    String path = "/sdcard/download/";

    var randid = random.nextInt(10000);
    try {
      await dio.download(
        widget.oldReport!,
        path + "$fullName" "OldReport" + randid.toString() + ".jpg",
        onReceiveProgress: (recivedBytes, totalBytes) {
          setState(() {
            downloading = true;
            progress =
                ((recivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
          });

          print(progress);
        },
        deleteOnError: true,
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progress = "Download Completed.";
      path = "Report" + randid.toString() + ".jpg";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Download Successful",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          duration: const Duration(seconds: 3),
          dismissDirection: DismissDirection.down,
        ),
      );
    });
  }

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
        profileUrl = _userModel.profilePicture;
        firstName = _userModel.firstName!;
        lastName = _userModel.lastName!;
        email = _userModel.email;
        fullName = firstName + " " + lastName;
        contactNumber = _userModel.contact;
        fullName = fullName!.toUpperCase();
        print(fullName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toString();
    int _indexSelected = 3;
    final screen = MediaQuery.of(context).size;
    return SafeArea(
      child: loading
          ? const Loading()
          : Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: GNav(
                activeColor: const Color(0xffd36868),
                color: Colors.black45,
                tabBackgroundColor: const Color(0xFFF1EFEF),
                padding: const EdgeInsets.all(16),
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
                      icon: Icons.date_range_rounded,
                      text: 'Schedule',
                      textSize: 12),
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
              body: downloading
                  ? Center(
                      child: SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: Card(
                          color: COLOR_SECONDARY,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const CircularProgressIndicator(),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Downloading File: $progress',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
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
                                      image:
                                          AssetImage('assets/images/bak.png'),
                                      fit: BoxFit.fill),
                                ),
                              )),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
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
                                            backgroundImage:
                                                NetworkImage("$profileUrl"),
                                            radius: 80,
                                          ),
                                    const Divider(
                                      color: Colors.white,
                                    ),
                                    fullName == null || fullName == ""
                                        ? const Text(
                                            "",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        : Text(
                                            "$fullName",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Color(0xff5d5ba3),
                                                fontWeight: FontWeight.bold,
                                              ),
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
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff5d5ba3)),
                                            ),
                                          ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
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
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff5d5ba3))),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                2, 10, 0, 0),
                                            child: Text(
                                              "$contactNumber",
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff5d5ba3),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          2, 10, 0, 5),
                                      child: Text(
                                        "Report:",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 11, 0, 5),
                                      child: Text(
                                        "Click on Image to Download Report",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.yellow.shade900)),
                                      ),
                                    ),
                                  ],
                                ),
                                widget.oldReport != null ||
                                        widget.oldReport != ""
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              loading = true;
                                              Future.delayed(
                                                  const Duration(seconds: 3),
                                                  () {
                                                setState(() {
                                                  startDownloading();
                                                });
                                              });
                                            });
                                          },
                                          child: SizedBox(
                                            height: screen.height / 3,
                                            width: screen.width / 1.2,
                                            child: Image.network(
                                              "${widget.oldReport}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
    );
  }
}
