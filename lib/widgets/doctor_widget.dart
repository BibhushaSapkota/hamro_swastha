import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/screens/doctor_profile_screen.dart';

// ignore: must_be_immutable
class DoctorWidget extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  final Doctor doctor;

  DoctorWidget(this.doctor, {Key? key}) : super(key: key);
  DoctorHistoryModel doctorHistoryModel = DoctorHistoryModel();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorProfileScreen(doctor: doctor)));
        doctorHistoryModel.id = doctor.id;
        doctorHistoryModel.description = doctor.description;
        doctorHistoryModel.image = doctor.image;
        doctorHistoryModel.name = doctor.name;
        doctorHistoryModel.orgName = doctor.orgName;
        doctorHistoryModel.schedule = doctor.schedule;
        doctorHistoryModel.specialization = doctor.specialization;
        print(doctorHistoryModel.id);
        await FirebaseFirestore.instance
            .collection('${user?.uid}')
            .doc(doctor.id)
            .set(doctorHistoryModel.toMap());
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: doctor.image == ""
                  ? Image.asset(
                      "assets/images/profile.jpg",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      doctor.image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: doctor.orgName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: ' (' + doctor.specialization + ')',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 16,
                      ),
                      Text(
                        doctor.schedule,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
