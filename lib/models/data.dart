import 'package:flutter/material.dart';
import 'package:mero_doctor/models/models.dart';

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

class DoctorListData {
  final List doctorList = [
    // Doctor(
    //   "Dr. Late Bajracharya",
    //   "assets/images/ic_topDoctor.png",
    //   "Gyneocology",
    //   "MD Psychiatry",
    //   "10:00 - 12:00",
    //   "Dr. Late Bajracharya  MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
    //       "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
    //       "surgery in Nepal. He is considered a good manager of the public hospitals.",
    // ),
  ];
}

class BookMarked {
  final List bookMarked = [];
}

final List DiseasesList = [
  DiseasesCategory("assets/images/ic_heart.png", 'Cardiology'),
  DiseasesCategory("assets/images/ic_teeth.png", 'Dermatology'),
  DiseasesCategory("assets/images/ic_eye.png", 'Psychiatry'),
  DiseasesCategory("assets/images/ic_fever.png", 'Nephrology'),
  // DiseasesCategory("assets/images/ic_cancer.png", 'Rectal Surgeon'),
  // DiseasesCategory("assets/images/ic_covid.png", 'Covid'),
  // DiseasesCategory("assets/images/ic_diarhea.png", 'Gastroenterologists'),
  // DiseasesCategory("assets/images/ic_anaemia.png", 'Anaemia'),
  // DiseasesCategory("assets/images/ic_tuberclosis.png", 'Tuberculosis'),
  // DiseasesCategory("assets/images/ic_alzheimer.png", 'Alzheimer'),
];

final List DoctorList = [
  TopDoctorCategory("assets/images/ic_topDoctor.png", 'Dr.Stordis Ben',
      'Heart Surgeon', const Color(0xffedf1fa), const Color(0xff3a69d0)),
  TopDoctorCategory("assets/images/ic_topDoctor2.png", 'Dr.Bina Zen',
      'Eye Surgeon', const Color(0xfff9f3eb), const Color(0xffffb060)),
  TopDoctorCategory("assets/images/ic_topDoctor3.png", 'Dr.Bina Zen',
      'Eye Surgeon', const Color(0x0cc1a6c4), const Color(0xffffc1af)),
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
    "assets/images/profile.jpg",
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
