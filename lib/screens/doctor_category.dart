import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/category.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/widgets/doctor_widget.dart';

class DoctorCategoryScreen extends StatefulWidget {
  final DiseasesCategory category;
  DoctorCategoryScreen({required this.category, Key? key}) : super(key: key);

  @override
  State<DoctorCategoryScreen> createState() => _DoctorCategoryScreenState();
}

class _DoctorCategoryScreenState extends State<DoctorCategoryScreen> {
  DoctorModel doctorModel = DoctorModel();
  List cardiology = [];
  List dermatology = [];
  List psychiatry = [];
  List nephroloy = [];

  @override
  void initState() {
    super.initState();
    AllDoctorSpecialization();
  }

  // ignore: non_constant_identifier_names
  AllDoctorSpecialization() async {
    await FirebaseFirestore.instance.collection('doctors').get().then((value) {
      value.docs.forEach((element) {
        doctorModel = DoctorModel.fromMap(element.data());
        print('Doctor Specialization.......');
        print(doctorModel.specialization);
        String id = "${doctorModel.docid}";
        String name = "${doctorModel.firstName} ${doctorModel.lastName}";
        String image = "";
        if (doctorModel.profileImageDownloadURL != null) {
          setState(() {
            image = "${doctorModel.profileImageDownloadURL}";
          });
        }

        String orgName = "${doctorModel.position}";
        String schedule = "";
        String description = "${doctorModel.description}";

// -------------------------- Cardiologist ---------------------------------------
        if (doctorModel.specialization == "Cardiologist") {
          String Cardiologist = "${doctorModel.specialization}";

          setState(() {
            cardiology.add(Doctor(
                id, name, image, orgName, Cardiologist, schedule, description));
          });
        }
// -------------------------- Dermatology ---------------------------------------
        else if (doctorModel.specialization == 'Dermatology') {
          String Dermatology = "${doctorModel.specialization}";
          setState(() {
            dermatology.add(Doctor(
                id, name, image, orgName, Dermatology, schedule, description));
          });
        }

// -------------------------- Psychiatry ---------------------------------------
        else if (doctorModel.specialization == 'Psychiatry') {
          String Psychiatry = "${doctorModel.specialization}";
          setState(() {
            psychiatry.add(Doctor(
                id, name, image, orgName, Psychiatry, schedule, description));
          });
        }
// -------------------------- Nephrology ---------------------------------------
        else if (doctorModel.specialization == 'Nephrology') {
          String Nephrology = "${doctorModel.specialization}";
          setState(() {
            nephroloy.add(Doctor(
                id, name, image, orgName, Nephrology, schedule, description));
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 70,
          title: Txt(
            widget.category.name,
            style: TxtStyle()
              ..fontSize(30)
              ..margin(left: 7, right: 16, top: 0)
              ..textColor(Colors.white)
              ..fontWeight(FontWeight.bold),
          ),
          backgroundColor: COLOR_SECONDARY,
          // elevation: 0,
        ),
        body: SizedBox(
          height: screen.height,
          width: screen.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Parent(
                style: ParentStyle()
                  ..height(200)
                  ..margin(left: 16, right: 16)
                  ..background.color(const Color(0xff76B5C5))
                  ..borderRadius(all: 10.0)
                  ..width(screen.width),
                child: Image.asset(
                  'assets/images/categories2.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                  child: widget.category.name == 'Cardiology'
                      ? ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: cardiology.length,
                          itemBuilder: (BuildContext context, index) {
                            return DoctorWidget(cardiology[index]);
                          })
                      : widget.category.name == 'dermatology'
                          ? ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: dermatology.length,
                              itemBuilder: (BuildContext context, index) {
                                return DoctorWidget(dermatology[index]);
                              })
                          : widget.category.name == 'psychiatry'
                              ? ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: psychiatry.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return DoctorWidget(psychiatry[index]);
                                  })
                              : ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: nephroloy.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return DoctorWidget(nephroloy[index]);
                                  }))
            ],
          ),
        ),
      ),
    );
  }
}
