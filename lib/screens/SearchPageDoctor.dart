import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Choose_Authencation.dart';
import 'package:mero_doctor/screens/GoogleLogin/google_login.dart';
import 'package:mero_doctor/screens/doctor_profile_screen.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';

class SearchPageDoctor extends StatefulWidget {
  const SearchPageDoctor({Key? key}) : super(key: key);

  @override
  _SearchPageDoctorState createState() => _SearchPageDoctorState();
}

class _SearchPageDoctorState extends State<SearchPageDoctor> {
  // var uid = Uuid();

  DoctorModel doctor = DoctorModel();
  final CollectionReference data =
      FirebaseFirestore.instance.collection('doctors');

  TextEditingController _textEditingController = TextEditingController();

  List<Doctor> AllDoctorOnSearch = [];

  List<Doctor> AllDoctor = [];

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    data.get().then((value) => {
          value.docs.forEach((element) {
            doctor = DoctorModel.fromMap(element.data());
            setState(() {
              String? id;
              String? imageURL = "";
              String? position = "Not Specified";
              String? specialization = "Not Specified";
              String? description = "Not Specified";
              // print(
              //     'All Id........................................................');
              // print(id);

              if (doctor.docid != null) {
                id = doctor.docid;
              }
              if (doctor.profileImageDownloadURL != null) {
                imageURL = doctor.profileImageDownloadURL;
              }
              if (doctor.position != null) {
                position = doctor.position;
              }
              if (doctor.specialization != null) {
                specialization = doctor.specialization;
              }
              if (doctor.description != null) {
                description = doctor.description;
              }

              print('ImageURLS');
              print(imageURL);
              print(doctor.position);
              print(doctor.specialization);
              print(doctor.description);

              this.AllDoctor.add(Doctor(id!, doctor.firstName!, imageURL!,
                  position!, specialization!, "12:00", description!));
              // this.AllDoctor.add(Doctor(id!, name!, image!, "orgName",
              //     "qualification", "123123", "description"));
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR_SECONDARY,
          // elevation: 0,
          // title: TextField(
          //     onChanged: (value) {
          //       setState(() {
          //         AllDoctorOnSearch = AllDoctor.where((element) => element
          //             .firstName!
          //             .toLowerCase()
          //             .contains(value.toLowerCase())).toList();
          //       });
          //     },
          //     controller: _textEditingController,
          //     decoration: const InputDecoration(
          //       border: InputBorder.none,
          //       errorBorder: InputBorder.none,
          //       focusedBorder: InputBorder.none,
          //       hintText: 'Search',
          //     )),
          //
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        onChanged: (value) {
                          print('asd');
                          setState(() {
                            AllDoctorOnSearch = AllDoctor.where((element) =>
                                element.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase())).toList();
                          });
                        },
                        controller: _textEditingController,
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
            _textEditingController.text.isEmpty || AllDoctorOnSearch.length == 0
                ? Expanded(
                    child: Center(
                      child: Text('No Result found!'),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: _textEditingController.text.isNotEmpty
                            ? AllDoctorOnSearch.length
                            : AllDoctor.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              print(AllDoctorOnSearch[index].name);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorProfileScreen(
                                          doctor: AllDoctorOnSearch[index])));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Row(
                                children: [
                                  AllDoctorOnSearch[index].image.toString() !=
                                          ""
                                      ? CircleAvatar(
                                          backgroundColor: Colors.green[100],
                                          backgroundImage: NetworkImage(
                                              AllDoctorOnSearch[index]
                                                  .image
                                                  .toString()),
                                          // child: Image.network(AllDoctorOnSearch[index].image),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.green[100],
                                          backgroundImage: const AssetImage(
                                              "assets/images/profile.jpg"),
                                          // child: Image.network(AllDoctorOnSearch[index].image),
                                        ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _textEditingController.text.isNotEmpty
                                        ? AllDoctorOnSearch[index].name
                                        : AllDoctor[index].name,
                                    // ? foodonSearch[index]
                                    // : food[index],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
          ],
        ));
  }
}
