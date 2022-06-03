import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/widgets/doctor_widget.dart';
import 'package:mero_doctor/models/data.dart';
import '../models/data.dart';
import '../models/models.dart';

class DoctorListScreen extends StatelessWidget {
  demo doctor = demo();
  final CollectionReference data =
      FirebaseFirestore.instance.collection("doctors");

  // const DoctorListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: COLOR_SECONDARY));
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 16),
              child: Text(
                "Available Doctors",
                style: TextStyle(
                  color: COLOR_SECONDARY,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, top: 20, right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: COLOR_SECONDARY,
              ),
              width: double.infinity,
              height: 150,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      "assets/images/ic_doctorlist.png",
                      height: 130,
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Looking for your desired\nSpecialist Doctors?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: doctor.doctorList.length,
                itemBuilder: (BuildContext context, index) {
                  return DoctorWidget(doctor.doctorList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
