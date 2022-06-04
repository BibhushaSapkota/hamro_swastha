import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mero_doctor/models/data.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/patient_profile.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/widgets/category_widget.dart';
import 'package:mero_doctor/widgets/doctor_category_widget.dart';

import '../widgets/doctor_top_widget.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key, required this.id, this.profileUrl})
      : super(key: key);
  String id;
  String? profileUrl;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState(id, profileUrl);
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? profileUrl;
  String id;

  _DashboardScreenState(this.id, this.profileUrl);
  UserModel? userModel = UserModel();

  @override
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: const GNav(
              activeColor: Color(0xffd36868),
              color: Colors.black45,
              tabBackgroundColor: Color(0xFFF1EFEF),
              padding: EdgeInsets.all(16),
              gap: 10,
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 400),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  textSize: 12,
                ),
                GButton(
                    icon: Icons.date_range_rounded,
                    text: 'Schedule',
                    textSize: 12),
                GButton(
                    icon: Icons.notifications_active_rounded,
                    text: 'Notification',
                    textSize: 12),
                GButton(icon: Icons.person, text: 'Profile', textSize: 12),
              ],
            ),
            backgroundColor: const Color(0xfff9f9f9),
            body: ListView(
              itemExtent: screen.height,
              physics: const BouncingScrollPhysics(),
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          "Find Your Desired\nConsultant",
                          style: TxtStyle()
                            ..fontSize(25)
                            ..fontFamily("quicksand")
                            ..fontWeight(FontWeight.bold)
                            ..textColor(const Color(0xff2c295b)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen(
                                                    id: id,
                                                    profilePicture: profileUrl,
                                                  )),
                                          (route) => false);
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                        "${profileUrl}",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 20,
                            color: Colors.grey.withOpacity(0.23),
                          )
                        ]),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for a doctor',
                                hintStyle: TextStyle(
                                  fontFamily: 'quicksand',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: 'quicksand',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Parent(
                          style: ParentStyle()
                            ..height(60)
                            ..width(70)
                            ..background.color(const Color(0xfff58173))
                            ..borderRadius(all: 40),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 140,
                    child: ListView(
                      padding: const EdgeInsets.only(left: 24),
                      scrollDirection: Axis.horizontal,
                      children: DiseasesList.map((e) => DoctorCategoryWidget(e))
                          .toList(),
                    ),
                  ),
                  Txt(
                    "Top Categories",
                    style: TxtStyle()
                      ..fontFamily('quicksand')
                      ..fontSize(18)
                      ..margin(right: 24, left: 24)
                      ..fontWeight(FontWeight.bold)
                      ..textColor(const Color(0xff535282)),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children:
                          DoctorList.map((e) => TopDoctorWidget(e)).toList(),
                    ),
                  )
                ]),
              ],
            )));
  }
}
