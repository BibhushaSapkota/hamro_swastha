import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mero_doctor/models/data.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/MessagepagePatient.dart';
import 'package:mero_doctor/screens/SearchPageDoctor.dart';
import 'package:mero_doctor/screens/patient_profile.dart';
import 'package:mero_doctor/utils/capatalize.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/widgets/doctor_category_widget.dart';
import 'package:mero_doctor/widgets/doctor_list_view.dart';
import 'package:mero_doctor/widgets/doctor_widget.dart';

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
  _DashboardScreenState(this.id, this.profileUrl);
  UserModel? userModel = UserModel();
  String? profileUrl;
  String id;
  final DoctorListData _doctorListData = DoctorListData();

  DoctorModel doctorModel = DoctorModel();
  final CollectionReference _data =
      FirebaseFirestore.instance.collection("doctors");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data.get().then((value) {
      value.docs.forEach((element) {
        doctorModel = DoctorModel.fromMap(element.data());
        String? firstName;
        String? lastName;
        String? fullName;
        String? imageUrl = "";
        String? specialization;
        String? description;
        String? docid = "";
        setState(() {
          docid = doctorModel.docid.toString();
          firstName = doctorModel.firstName.toString();
          lastName = doctorModel.lastName.toString();
          String capFirst = capitalize(firstName!);
          String capLast = capitalize(lastName!);
          fullName = "${capFirst} ${capLast}";
          if (doctorModel.profileImageDownloadURL != null) {
            imageUrl = doctorModel.profileImageDownloadURL;
          } else {
            print(doctorModel.profileImageDownloadURL);
          }
          specialization = doctorModel.specialization;
          description = doctorModel.description;
          print(description);
        });
        _doctorListData.doctorList.add(Doctor(docid!, fullName!, imageUrl!, '',
            specialization!, '', description!));
      });
    });
  }

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileScreen(
                                                        id: id,
                                                        profilePicture:
                                                            profileUrl,
                                                      )),
                                              (route) => false);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          child: profileUrl == "" ||
                                                  profileUrl == null
                                              ? Image.asset(
                                                  "/assets/images/profile.jpg")
                                              : Image.network(profileUrl!),
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
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PatientMessagePage()));
                            },
                            color: COLOR_SECONDARY,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text('Messages',
                                style: TextStyle(
                                    // decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 15)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
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
                                          const SearchPageDoctor()));
                            },
                            child: Text(
                              'Search Doctors by name.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 140,
                      child: ListView(
                        padding: const EdgeInsets.only(left: 24),
                        scrollDirection: Axis.horizontal,
                        children:
                            DiseasesList.map((e) => DoctorCategoryWidget(e))
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: _doctorListData.doctorList.length,
                        itemBuilder: (BuildContext context, index) {
                          return DoctorListView(
                              _doctorListData.doctorList[index], id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
