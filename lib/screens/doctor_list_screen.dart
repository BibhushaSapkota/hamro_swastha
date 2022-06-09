import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/widgets/doctor_widget.dart';
import 'package:mero_doctor/models/data.dart';
import '../models/data.dart';
import '../models/models.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  DoctorListData doctor_list = DoctorListData();
  DoctorModel doctor_data = DoctorModel();
  final CollectionReference data =
      FirebaseFirestore.instance.collection("doctors");

  @override
  void initState() {
    super.initState();

    data.get().then((value) {
      value.docs.forEach((element) {
        this.doctor_data = DoctorModel.fromMap(element.data());
        String? name;
        String? imageURL = "";
        String? qualification;
        String? orgName;
        print(
            "---------------------------- Doctor data ----------------------------");
        setState(() {
          name = "${doctor_data.firstName} ${doctor_data.lastName}";
          print("Profile Pic..............");
          if (doctor_data.profileImageDownloadURL != null) {
            imageURL = doctor_data.profileImageDownloadURL;
          }
          print(imageURL);
        });
        this.doctor_list.doctorList.add(Doctor(name!, imageURL!, "orgName",
            "qualification", "12323", "description"));
      });
    });
  }

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
                itemCount: doctor_list.doctorList.length,
                itemBuilder: (BuildContext context, index) {
                  return DoctorWidget(doctor_list.doctorList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}