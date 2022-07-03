import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/data.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/doctor_profile_screen.dart';
import 'package:mero_doctor/utils/constants.dart';

class DoctorListView extends StatefulWidget {
  final Doctor doctor;
  String? uid;
  String? profileUrl;
  DoctorListView({required this.doctor, this.uid, this.profileUrl}) : super();

  @override
  State<DoctorListView> createState() => _DoctorListViewState(doctor, uid);
}

class _DoctorListViewState extends State<DoctorListView> {
  _DoctorListViewState(this.doctor, this.uid);
  final Doctor doctor;
  String? uid;

  final BookMarked _bookMarked = BookMarked();

  final List bookList = [];
  final UserModel _userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorProfileScreen(
                      doctor: doctor,
                      profileUrl: widget.profileUrl,
                    )));
      },
      child: Parent(
        style: ParentStyle()
          ..height(84)
          ..borderRadius(all: 10)
          ..margin(top: 10)
          ..width(screen.width)
          ..elevation(3, color: Colors.grey.shade200)
          ..background.color(const Color(0xfff9f3eb)),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Parent(
                      style: ParentStyle()
                        ..width(60)
                        ..height(60)
                        ..borderRadius(all: 60)
                        ..elevation(4, color: Colors.grey.shade300)
                        ..background.color(const Color(0xffffb060))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: widget.doctor.image == ""
                        ? const CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              "assets/images/profile.jpg",
                            ))
                        : CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(widget.doctor.image),
                          ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      widget.doctor.name,
                      style: TxtStyle()
                        ..fontSize(16)
                        ..textColor(const Color(0xff7f819b))
                        ..fontWeight(FontWeight.w600)
                        ..textColor(Colors.black),
                    ),
                    Txt(
                      widget.doctor.specialization,
                      style: TxtStyle()
                        ..textColor(const Color(0xff5d5ba3))
                        ..fontWeight(FontWeight.bold)
                        ..fontSize(12)
                        ..margin(top: 4),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (_bookMarked.bookMarked.contains(doctor.id)) {
                      _bookMarked.bookMarked.remove(doctor.id);
                    } else {
                      _bookMarked.bookMarked.add(doctor.id);
                    }
                  });
                },
                icon: _bookMarked.bookMarked.contains(doctor.id)
                    ? const Icon(
                        Icons.bookmark_add,
                        color: COLOR_PRIMARY,
                        size: 35,
                      )
                    : const Icon(
                        Icons.bookmark_add_outlined,
                        size: 35,
                        color: COLOR_GREY,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
