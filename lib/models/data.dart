import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mero_doctor/models/user.dart';

final List categoryList = [
  Category(
    "assets/images/ic_dashboard1.png",
    "Cough and\nCold",
    const Color(0xffdfb9a4),
  ),
  Category(
    "assets/images/ic_dashboard2.png",
    "Heart Diseases",
    const Color(0xff61a7b7),
  ),
  Category(
    "assets/images/ic_dashboard4.png",
    "Diabetes Care",
    const Color(0xffbbeebb),
  ),
  Category(
    "assets/images/ic_dashboard9.png",
    "Cancer",
    const Color(0xffa1a6c4),
  ),
  Category(
    "assets/images/ic_dashboard5.png",
    "Cancer",
    const Color(0xffffc1af),
  ),
  Category(
    "assets/images/ic_dashboard6.png",
    "Cancer",
    const Color(0xffdea5a4),
  ),
];

class demo {
  User? user = FirebaseAuth.instance.currentUser;
  DoctorModel docImage = DoctorModel();
  String? image;

  void Alldata() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(user?.uid)
        .get()
        .then((value) {
      this.docImage = DoctorModel.fromMap(value.data());
    }).whenComplete(() {
      image = docImage.profileImageDownloadURL;
      print("Image Url............");
      print(image);
    });
  }

  final List doctorList = [
    Doctor(
      "Dr. Late Bajracharya",
      "assets/images/ic_topDoctor.png",
      "Gyneocology",
      "MD Psychiatry",
      "10:00 - 12:00",
      "Dr. Late Bajracharya  MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
          "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
          "surgery in Nepal. He is considered a good manager of the public hospitals.",
    ),
    Doctor(
      "Dr. Raju Pangeni",
      "assets/images/ic_topDoctor2.png",
      "General Medicine",
      "MD, Fellow in Pain",
      "6:00 - 9:00",
      "Dr. Raju Pangeni MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
          "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
          "surgery in Nepal. He is considered a good manager of the public hospitals.",
    ),
    Doctor(
        "Dr. Reet Poudel",
        "assets/images/ic_topDoctor3.png",
        "Psychiatric",
        "MBBS,MD",
        "12:00 - 4:00",
        " Dr. Reet Poudel MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
            "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
            "surgery in Nepal. He is considered a good manager of the public hospitals."),
    Doctor(
        "Dr. Lata Gautam",
        "assets/images/ic_topDoctor2.png",
        "Psychiatric",
        "MBBS, MD",
        "11:00 - 3:00",
        " Dr. Lata Gautam MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
            "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
            "surgery in Nepal. He is considered a good manager of the public hospitals."),
    Doctor(
        "Dr. Roshan Piya",
        "assets/images/ic_topDoctor3.png",
        "Pain Management",
        "COS",
        "5:00 - 8:00",
        "  Dr. Roshan Piya MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
            "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
            "surgery in Nepal. He is considered a good manager of the public hospitals."),
    Doctor(
        "Dr. Om Narayan Jha",
        "assets/images/ic_topDoctor3.png",
        "General Medicine",
        "MP, COS",
        "8:00 - 12:00",
        "  Dr. Om Narayan Jha MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
            "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
            "surgery in Nepal. He is considered a good manager of the public hospitals."),
    Doctor(
        "Dr. Manish Pokhral",
        "assets/images/ic_topDoctor2.png",
        "Cardiology",
        "DM-Cardiology",
        "6:00 - 11:00",
        " Dr. Manish Pokhral MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
            "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
            "surgery in Nepal. He is considered a good manager of the public hospitals."),
  ];
}

final List DiseasesList = [
  DiseasesCategory("assets/images/ic_heart.png", 'Cardiology'),
  DiseasesCategory("assets/images/ic_teeth.png", 'Dentist'),
  DiseasesCategory("assets/images/ic_eye.png", 'Eye Specialist'),
  DiseasesCategory("assets/images/ic_fever.png", 'General'),
  DiseasesCategory("assets/images/ic_cancer.png", 'Rectal Surgeon'),
  DiseasesCategory("assets/images/ic_covid.png", 'Covid'),
  DiseasesCategory("assets/images/ic_diarhea.png", 'Gastroenterologists'),
  DiseasesCategory("assets/images/ic_anaemia.png", 'Anaemia'),
  DiseasesCategory("assets/images/ic_tuberclosis.png", 'Tuberculosis'),
  DiseasesCategory("assets/images/ic_alzheimer.png", 'Alzheimer'),
];

final List DoctorList = [
  TopDoctorCategory("assets/images/ic_topDoctor.png", 'Dr.Stordis Ben',
      'Heart Surgeon', const Color(0xffedf1fa), const Color(0xff3a69d0)),
  TopDoctorCategory("assets/images/ic_topDoctor2.png", 'Dr.Bina Zen',
      'Eye Surgeon', const Color(0xfff9f3eb), const Color(0xffffb060)),
  TopDoctorCategory("assets/images/ic_topDoctor3.png", 'Dr.Bina Zen',
      'Eye Surgeon', const Color(0xcc1a6c4), const Color(0xffffc1af)),
  TopDoctorCategory("assets/images/ic_topDoctor2.png", 'Dr.Bina Zen',
      'Eye Surgeon', const Color(0xfff9f3eb), const Color(0xffffb060)),
];
final List DoctorDashBoard = [
  DoctorWidgets(
    "assets/images/ic_topDoctor.png",
    'Dr.Stordis Ben',
    'Time:9:00 AM',
  ),
  DoctorWidgets(
    "assets/images/profile.png",
    'Dr.Bina Zen',
    'Time:9:00 AM',
  ),
  DoctorWidgets(
    "assets/images/ic_topDoctor3.png",
    'Dr.Bina Zen',
    'Time:9:00 AM',
  ),
  DoctorWidgets(
    "assets/images/ic_topDoctor2.png",
    'Dr.Bina Zen',
    'Time:9:00 AM',
  ),
];
