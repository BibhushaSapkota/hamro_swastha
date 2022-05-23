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
  ), Category(
    "assets/images/ic_dashboard6.png",
    "Cancer",
    const Color(0xffdea5a4),
  ),
];

final List doctorList = [
  Doctor(
    "Dr. Late Bajracharya",
    "https://www.nepalmediciti.com/UploadedImages/Dr.%20lata2.jpg",
    "Gyneocology",
    "MD Psychiatry",
    "10:00 - 12:00",
    "Dr. Late Bajracharya  MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
        "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
        "surgery in Nepal. He is considered a good manager of the public hospitals.",
  ),
  Doctor(
    "Dr. Raju Pangeni",
    "https://hamshospital.com/wp-content/uploads/2018/07/Dr.-Raju-Pangeni.jpg",
    "General Medicine",
    "MD, Fellow in Pain",
    "6:00 - 9:00",
    "Dr. Raju Pangeni MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
        "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
        "surgery in Nepal. He is considered a good manager of the public hospitals.",
  ),
  Doctor(
      "Dr. Reet Poudel",
      "https://b360nepal.com/wp-content/uploads/2020/09/Dr.-Nikesh-Rajbhandari-1.jpg",
      "Psychiatric",
      "MBBS,MD",
      "12:00 - 4:00",
      " Dr. Reet Poudel MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
          "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
          "surgery in Nepal. He is considered a good manager of the public hospitals."),
  Doctor(
      "Dr. Lata Gautam",
      "http://aru.ac.uk/-/media/Images/Faculty/fst/biomedical-and-forensic-sciences/staff_234x234/lata-gautam2_234x234.jpg",
      "Psychiatric",
      "MBBS, MD",
      "11:00 - 3:00",
      " Dr. Lata Gautam MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
          "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
          "surgery in Nepal. He is considered a good manager of the public hospitals."),
  Doctor(
      "Dr. Roshan Piya",
      "https://nepalpaincarecenter.com/wp-content/uploads/2020/12/dr.roshan.png",
      "Pain Management",
      "COS",
      "5:00 - 8:00",
      "  Dr. Roshan Piya MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
          "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
          "surgery in Nepal. He is considered a good manager of the public hospitals."),
  Doctor(
      "Dr. Om Narayan Jha",
      "https://omhospitalnepal.com/main_domain/wp-content/uploads/2020/06/10.1_Dr.-A.K-jha-2-500x500.jpg",
      "General Medicine",
      "MP, COS",
      "8:00 - 12:00",
      "  Dr. Om Narayan Jha MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
          "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
          "surgery in Nepal. He is considered a good manager of the public hospitals."),
  Doctor(
      "Dr. Manish Pokhral",
      "https://omhospitalnepal.com/main_domain/wp-content/uploads/2020/12/nabin-pokhrel-500x500.jpg",
      "Cardiology",
      "DM-Cardiology",
      "6:00 - 11:00",
      " Dr. Manish Pokhral MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
          "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
          "surgery in Nepal. He is considered a good manager of the public hospitals."),
];

final List DiseasesList=[
  DiseasesCategory("assets/images/ic_heart.png",'Cardiology'),
  DiseasesCategory("assets/images/ic_teeth.png",'Dentist'),
  DiseasesCategory("assets/images/ic_eye.png",'Eye Specialist'),
  DiseasesCategory("assets/images/ic_fever.png",'General'),
  DiseasesCategory("assets/images/ic_cancer.png",'Rectal Surgeon'),
  DiseasesCategory("assets/images/ic_covid.png",'Covid'),
  DiseasesCategory("assets/images/ic_diarhea.png",'Gastroenterologists'),
  DiseasesCategory("assets/images/ic_anaemia.png",'Anaemia'),
  DiseasesCategory("assets/images/ic_tuberclosis.png",'Tuberculosis'),
  DiseasesCategory("assets/images/ic_alzheimer.png",'Alzheimer'),

];

final List DoctorList=[
  TopDoctorCategory("assets/images/ic_topDoctor.png",'Dr.Stordis Ben','Heart Surgeon',const Color(0xffedf1fa),const Color(0xff3a69d0)),
  TopDoctorCategory("assets/images/ic_topDoctor2.png",'Dr.Bina Zen','Eye Surgeon',const Color(0xfff9f3eb),const Color(0xffffb060)),
  TopDoctorCategory("assets/images/ic_topDoctor3.png",'Dr.Bina Zen','Eye Surgeon',const Color(0xcc1a6c4),const Color(0xffffc1af)),
  TopDoctorCategory("assets/images/ic_topDoctor2.png",'Dr.Bina Zen','Eye Surgeon',const Color(0xfff9f3eb),const Color(0xffffb060)),



];
