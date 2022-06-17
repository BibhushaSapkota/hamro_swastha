import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/screens/doctor_list_screen.dart';
import 'package:mero_doctor/widgets/doctor_widget.dart';

class DoctorHistoryScreen extends StatefulWidget {
  @override
  State<DoctorHistoryScreen> createState() => _DoctorHistoryScreenState();
}

class _DoctorHistoryScreenState extends State<DoctorHistoryScreen> {
  DoctorHistoryModel doctorHistoryModel = DoctorHistoryModel();
  User? user = FirebaseAuth.instance.currentUser;
  List DoctorHistory = [];

  @override
  void initState() {
    super.initState();

    print('Printed......');
    final CollectionReference data =
        FirebaseFirestore.instance.collection('${user?.uid}');
    data.get().then((value) => {
          value.docs.forEach((element) {
            doctorHistoryModel = DoctorHistoryModel.fromMap(element.data());
            String? id,
                name,
                image,
                orgName,
                specialization,
                schedule,
                description;

            setState(() {
              id = doctorHistoryModel.id;
              name = doctorHistoryModel.name;
              image = doctorHistoryModel.image;
              orgName = doctorHistoryModel.orgName;
              specialization = doctorHistoryModel.specialization;
              schedule = doctorHistoryModel.schedule;
              description = doctorHistoryModel.description;

              DoctorHistory.add(Doctor(id!, name!, image!, orgName!,
                  specialization!, schedule!, description!));
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.amber));
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => DoctorListScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
                      child: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                  const Text(
                    "Your History",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(left: 16, top: 20, right: 16),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10.0),
            //     color: Colors.green,
            //   ),
            //   width: double.infinity,
            //   height: 150,
            //   child: Stack(
            //     children: [
            //       Positioned(
            //         right: 0,
            //         bottom: 0,
            //         child: Image.asset(
            //           "assets/images/profile.png",
            //           height: 130,
            //         ),
            //       ),
            //       const Positioned(
            //         top: 0,
            //         left: 0,
            //         child: Padding(
            //           padding: EdgeInsets.all(10.0),
            //           child: Text(
            //             "Looking for your desired\nSpecialist Doctors?",
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 15),
            DoctorHistory.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: const Center(
                      child: Text(
                        'No Doctors checked yet.',
                        style: TextStyle(color: Colors.grey, fontSize: 20.0),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: DoctorHistory.length,
                      itemBuilder: (BuildContext context, index) {
                        return DoctorWidget(DoctorHistory[index]);
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
