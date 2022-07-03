import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/MessagepageDoctor.dart';
import 'package:mero_doctor/screens/SearchPage.dart';
import 'package:mero_doctor/utils/constants.dart';

import '../widgets/doctor_dashboard_widgets.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  List<Map<String, dynamic>> appointmentList = [];
  DoctorModel doctorModel = DoctorModel();
  final _user = FirebaseAuth.instance.currentUser!.uid;
  String? profileUrl;
  final CollectionReference data =
      FirebaseFirestore.instance.collection("doctors");

  @override
  void initState() {
    super.initState();
    data.doc(_user).get().then((value) {
      doctorModel = DoctorModel.fromMap(value.data());
      setState(() {
        profileUrl = doctorModel.profileImageDownloadURL.toString();
        print(profileUrl);
      });
    });
    data.doc(_user).collection("UpcomingAppointment").get().then((value) {
      setState(() {
        for (var doc in value.docs) {
          appointmentList.add(doc.data());
        }
      });
    });
  }

  // Future getUpcomingAppointment() async {
  //   var result = await data.doc(_user).collection("UpcomingAppointment").get();
  //   for (var doc in result.docs) {
  //     appointmentList.add(doc.data());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          itemExtent: screen.height,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(
                      'Doctors For Life',
                      style: TxtStyle()
                        ..fontSize(22)
                        ..padding(horizontal: 24, vertical: 10)
                        ..fontWeight(FontWeight.bold)
                        ..textColor(Colors.black)
                        ..fontFamily('quicksand'),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onTap: () {
                          print('Profile');
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: profileUrl == "" || profileUrl == null
                              ? Image.asset("/assets/images/profile.jpg")
                              : Image.network(profileUrl!),
                        ),
                      ),
                    )
                  ],
                ),
                // Parent(
                //   style: ParentStyle()
                //     ..borderRadius(all: 15)
                //     ..background.image(
                //         path: 'assets/images/profile.jpg', fit: BoxFit.cover)
                //     ..width(screen.width)
                //     ..height(200)
                //     ..margin(
                //       bottom: 10,
                //     )
                //     ..boxShadow(
                //         color: const Color(0xffe6e3fe),
                //         blur: 10,
                //         offset: const Offset(0, 5)),
                // ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MessagePageDoctor()));
                        },
                        color: COLOR_SECONDARY,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: const Text('Messages',
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 15)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: MaterialButton(
                        color: COLOR_SECONDARY,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchPagePatient()));
                        },
                        child: const Text(
                          'Search Patient by name.',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                // Center(
                //   child: Txt(
                //     ' Save Your Life',
                //     style: TxtStyle()
                //       ..fontSize(20)
                //       ..fontWeight(FontWeight.bold)
                //       ..textColor(Colors.black)
                //       ..fontFamily('quicksand'),
                //   ),
                // ),
                Txt(
                  ' Schedules',
                  style: TxtStyle()
                    ..fontSize(22)
                    ..padding(horizontal: 24, vertical: 10)
                    ..fontWeight(FontWeight.bold)
                    ..textColor(Colors.black)
                    ..fontFamily('quicksand'),
                ),
                SizedBox(
                  height: 80,
                  child: ListView(
                    padding: const EdgeInsets.only(left: 24, bottom: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      _getCategoryInfo("Sun", "01"),
                      _getCategoryInfo("Mon", "09"),
                      _getCategoryInfo("Tues", "07"),
                      _getCategoryInfo("Wed", "03"),
                      _getCategoryInfo("Thur", "12"),
                      _getCategoryInfo("Frid", "7"),
                    ],
                  ),
                ),
                Txt(
                  ' Appointments',
                  style: TxtStyle()
                    ..fontSize(22)
                    ..margin(horizontal: 24, vertical: 10)
                    ..fontWeight(FontWeight.bold)
                    ..textColor(Colors.black)
                    ..fontFamily('quicksand'),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: appointmentList.length,
                    itemBuilder: (BuildContext context, index) {
                      return DoctorDashBoardWidget(appointmentList[index]);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCategoryInfo(String title, String value) {
    return Parent(
      style: ParentStyle()
        ..height(80)
        ..width(80)
        ..elevation(3, color: Colors.grey.withOpacity(0.5))
        ..margin(right: 10)
        ..borderRadius(all: 10)
        ..background.color(Colors.grey.shade100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Txt(
            title,
            style: TxtStyle()
              ..fontSize(12)
              ..fontWeight(FontWeight.bold)
              ..textColor(const Color(0xff76B5C5)),
          ),
          Txt(
            value,
            style: TxtStyle()
              ..margin(top: 10)
              ..fontSize(12)
              ..textColor(Colors.black),
          )
        ],
      ),
    );
  }
}
