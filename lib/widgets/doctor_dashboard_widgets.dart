import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/patient_details_view.dart';

class DoctorDashBoardWidget extends StatefulWidget {
  final Map<String, dynamic>? category;

  DoctorDashBoardWidget({this.category}) : super();

  @override
  State<DoctorDashBoardWidget> createState() => _DoctorDashBoardWidgetState();
}

class _DoctorDashBoardWidgetState extends State<DoctorDashBoardWidget> {
  UserModel _userModel = UserModel();
  String? firstName;
  String? lastName;
  String? email;
  String? profileUrl;
  String? dateOfBirth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.category!['userUid'])
        .get()
        .then((value) {
      _userModel = UserModel.fromMap(value.data());
      setState(() {
        firstName = _userModel.firstName;
        lastName = _userModel.lastName;
        email = _userModel.email;
        profileUrl = _userModel.profilePicture;
        dateOfBirth = _userModel.date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Parent(
        style: ParentStyle()
          ..borderRadius(all: 10)
          ..height(100)
          ..background.color(Colors.white)
          ..elevation(3, color: Colors.grey.shade300)
          ..padding(all: 12)
          ..margin(bottom: 12)
          ..width(screen.width),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => PatientProfileView(
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          dateOfBirth: dateOfBirth,
                          profileUrl: profileUrl,
                        )),
                (route) => false);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(widget.category!["profilePicture"]),
              ),

              Column(
                children: [
                  Txt(
                    widget.category!["username"],
                    style: TxtStyle()
                      ..fontSize(16)
                      ..textColor(Colors.black)
                      ..fontFamily('quicksand'),
                  ),
                  Txt(
                    widget.category!["date"],
                    style: TxtStyle()
                      ..fontSize(16)
                      ..textColor(Colors.black)
                      ..fontFamily('quicksand'),
                  ),
                  Txt(
                    widget.category!["time"],
                    style: TxtStyle()
                      ..fontSize(16)
                      ..textColor(Colors.black)
                      ..fontFamily('quicksand'),
                  ),
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Parent(
              //       style: ParentStyle()
              //         ..height(24)
              //         ..elevation(3)
              //         ..background.color(const Color(0xff76B5C5))
              //         ..width(60)
              //         ..elevation(3)
              //         ..borderRadius(all: 12),
              //       child: Txt(
              //         'Accept',
              //         style: TxtStyle()
              //           ..fontSize(13)
              //           ..textColor(Colors.white)
              //           ..alignmentContent.center(),
              //       ),
              //     ),
              //     Parent(
              //         style: ParentStyle()
              //           ..height(24)
              //           ..elevation(3)
              //           ..background.color(Colors.red)
              //           ..width(60)
              //           ..elevation(3)
              //           ..borderRadius(all: 12),
              //         child: Txt(
              //           'Decline',
              //           style: TxtStyle()
              //             ..fontSize(13)
              //             ..textColor(Colors.white)
              //             ..alignmentContent.center(),
              //         ))
              //   ],
              // )
              const Icon(Icons.message, color: Colors.green),
            ],
          ),
        ));
  }
}
