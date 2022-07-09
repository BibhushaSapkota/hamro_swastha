import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notificationList = [];

  @override
  void initState() {
    super.initState();
    getNotification();
  }

  getNotification() async {
    var result = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("notification")
        .get();
    for (var doc in result.docs) {
      notificationList.add(doc.data());
    }
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: ListView(
                children:
                    notificationList.map((e) => _makeNotification(e)).toList()),
          ),
        ),
      ),
    );
  }
}

Widget _makeNotification(Map<String, dynamic> data) {
  return Parent(
    style: ParentStyle()
      ..background.color(Colors.white)
      ..width(Get.width)
      ..margin(top: 15)
      ..boxShadow(
          color: const Color(0xffdddef2), blur: 10, offset: const Offset(0, 6))
      ..borderRadius(all: 12),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.notifications, color: Colors.orange),
              Txt(
                "Appointment",
                style: TxtStyle()
                  ..fontSize(22)
                  ..fontFamily("quicksand")
                  ..fontWeight(FontWeight.bold)
                  ..textColor(Colors.black),
              ),
              Txt(
                data["date"],
                style: TxtStyle()
                  ..textColor(Colors.black45)
                  ..fontFamily("quicksand")
                  ..fontSize(16),
              )
            ],
          ),
          const SizedBox(height: 10),
          Txt(
            "Your appointment has been book on ${data['date']} ${data['time']} .",
            style: TxtStyle()
              ..textColor(Colors.black54)
              ..fontFamily("quicksand")
              ..textAlign.center()
              ..padding(all: 10)
              ..fontSize(16),
          ),
        ],
      ),
    ),
  );
}
