import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/snack_bar.dart';

class CalenderScreen extends StatefulWidget {
  final Doctor doctor;

  const CalenderScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  List<String> appointmentDate = [];
  int selectedIndex = -1;
  String selectedDate = "";
  final CollectionReference data =
      FirebaseFirestore.instance.collection("doctors");

  @override
  void initState() {
    super.initState();
  }

  getAppointmentDate(String selectedDate) {
    data.doc(widget.doctor.id).snapshots().listen((snapshot) {
      Map<String, dynamic> data = snapshot["appointmentDate"];
      if (data.containsKey(selectedDate)) {
        appointmentDate = List.from(data[selectedDate]);
      } else {
        appointmentDate = [];
      }
      setState(() => {appointmentDate = appointmentDate});
    });
  }

  bookAppointment() async {
    if (selectedIndex == -1) return;
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    UserModel userModel = UserModel.fromMap(user.data());
    String name = "${userModel.firstName}  ${userModel.lastName}";

    Map<String, String> appointment = {
      "date": selectedDate,
      "time": appointmentDate[selectedIndex],
      "username": name,
      "profilePicture": userModel.profilePicture ?? "",
    };

    try {
      await data
          .doc(widget.doctor.id)
          .collection("upcomingAppointment")
          .add(appointment);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackMessage.successSnackBar("Appointment booked successfully!!"));
    } catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackMessage.successSnackBar(ex.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffdaebff),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu,
                size: 26,
                color: Colors.black,
              ),
            ),
            Txt(
              'Calender',
              style: TxtStyle()
                ..fontSize(24)
                ..textColor(Colors.black)
                ..alignment.center()
                ..fontWeight(FontWeight.bold),
            ),
            Parent(
              style: ParentStyle()
                ..height(360)
                ..width(screen.width)
                ..borderRadius(all: 12),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                onDaySelected: (selectedDay, focusedDay) {
                  String selectedDat =
                      "${selectedDay.year}-${selectedDay.month < 10 ? "0${selectedDay.month}" : selectedDay.month}-${selectedDay.day}";
                  setState(() => {selectedDate = selectedDat});
                  getAppointmentDate(selectedDat);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Parent(
                  style: ParentStyle()
                    ..height(400)
                    ..width(screen.width)
                    ..background.color(Colors.white)
                    ..borderRadius(topLeft: 32, topRight: 32),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Txt(
                          'Time Slots',
                          style: TxtStyle()
                            ..fontSize(24)
                            ..padding(left: 16)
                            ..fontWeight(FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: SizedBox(
                            height: 86,
                            child: appointmentDate.isEmpty
                                ? const Text("No Time Slot Available.")
                                : ListView.builder(
                                    itemCount: appointmentDate.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return _getCategoryInfo(
                                          appointmentDate[index],
                                          Gestures()
                                            ..onTap(
                                              () {
                                                setState(() =>
                                                    {selectedIndex = index});
                                              },
                                            ),
                                          index,
                                          selectedIndex);
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Parent(
                              gesture: Gestures()
                                ..onTap(() => bookAppointment()),
                              style: ParentStyle()
                                ..height(52)
                                ..elevation(3, color: Colors.black12)
                                ..width(230)
                                ..margin(top: 18)
                                ..borderRadius(all: 16)
                                ..background.color(const Color(0xffEFB492)),
                              child: Txt(
                                'Book an Appointment',
                                style: TxtStyle()
                                  ..fontSize(16)
                                  ..fontFamily('quicksand')
                                  ..fontWeight(FontWeight.bold)
                                  ..padding(left: 42, top: 10)
                                  ..textColor(Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Txt(
                          'Powered By Mero Health',
                          style: TxtStyle()
                            ..fontSize(12)
                            ..alignment.center()
                            ..margin(top: 18)
                            ..fontFamily('quicksand')
                            ..fontWeight(FontWeight.w500)
                            ..textColor(Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}

Widget _getCategoryInfo(
    String value, Gestures gesture, int index, selectedIndex) {
  return Parent(
    gesture: gesture,
    style: ParentStyle()
      ..height(80)
      ..width(150)
      ..elevation(3, color: Colors.grey.withOpacity(0.5))
      ..margin(right: 10)
      ..borderRadius(all: 10)
      ..background.color((index == selectedIndex)
          ? const Color(0xff90a7c7)
          : const Color(0xffdaebff)),
    child: Txt(
      value,
      style: TxtStyle()
        ..margin(top: 10, left: 10)
        ..alignmentContent.center()
        ..fontSize(16)
        ..textColor(Colors.black),
    ),
  );
}
