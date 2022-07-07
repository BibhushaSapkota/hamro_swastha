import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  bool? isPatient;
  String? password;
  bool? isFormCompleted;
  bool? isNormalUser;
  bool? isGoogleUser;
  String? profilePicture;
  String? gender;
  String? contact;
  String? date;
  String? oldReportFile;
  List? bookMarked = [];

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.isPatient,
    this.isFormCompleted,
    this.profilePicture,
    this.gender,
    this.contact,
    this.date,
    this.oldReportFile,
    this.isGoogleUser,
    this.isNormalUser,
    this.bookMarked,
  });

  // Receiving Data from Server
  factory UserModel.fromMap(map) => UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        password: map['password'],
        isPatient: map['isPatient'],
        isFormCompleted: map['isFormCompleted'],
        profilePicture: map['profilePicture'],
        gender: map['gender'],
        contact: map['contact'],
        date: map['dateOfBirth'],
        oldReportFile: map['oldReportFile'],
        isGoogleUser: map['isGoogleUser'],
        isNormalUser: map['isNormalUser'],
      );

  // Sending Data to the Server
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "isPatient": isPatient,
      "isFormCompleted": isFormCompleted,
      "profilePicture": profilePicture,
      'gender': gender,
      'contact': contact,
      'dateOfBirth': date,
      'oldReportFile': oldReportFile,
      'isGoogleUser': isGoogleUser,
      'isNormalUser': isNormalUser,
      'bookMarked': bookMarked,
    };
  }

  Map<String, dynamic> transactionList(
      String date,
      String amount,
      String appointmentDate,
      bool isPaymentDone,
      String time,
      String appointmentTime,
      String doctorUid) {
    return {
      'transaction_date': date,
      'transaction_amount': amount,
      'apointment_date': appointmentDate,
      'isPaymentDone': isPaymentDone,
      'transaction_time': time,
      'time_slot': appointmentTime,
      'doctor': doctorUid,
    };
  }
}

class DoctorModel {
  String? docid;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  bool? isDoctor;
  String? specialization;
  String? position;
  String? profileImageDownloadURL;
  String? identificationImageDownloadURL;
  String? licenseImageDownloadURL;
  String? description;
  bool? isFormCompleted;
  bool? isGoogleUser;
  bool? isNormalUser;

  DoctorModel({
    this.docid,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.isDoctor,
    this.specialization,
    this.position,
    this.isFormCompleted,
    this.profileImageDownloadURL,
    this.identificationImageDownloadURL,
    this.licenseImageDownloadURL,
    this.description,
    this.isGoogleUser,
    this.isNormalUser,
  });

  // Receiving Data from Server
  factory DoctorModel.fromMap(map) {
    return DoctorModel(
      docid: map['docid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      password: map['password'],
      isDoctor: map['isDoctor'],
      specialization: map['specialization'],
      position: map['position'],
      profileImageDownloadURL: map['profileImageDownloadURL'],
      identificationImageDownloadURL: map['identificationImageDownloadURL'],
      licenseImageDownloadURL: map['licenseImageDownloadURL'],
      description: map['description'],
      isFormCompleted: map['isFormCompleted'],
      isGoogleUser: map['isGoogleUser'],
      isNormalUser: map['isNormalUser'],
    );
  }

  // Sending Data to the Server
  Map<String, dynamic> toMap() {
    return {
      "docid": docid,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "isDoctor": isDoctor,
      "specialization": specialization,
      "position": position,
      "profileImageDownloadURL": profileImageDownloadURL,
      "identificationImageDownloadURL": identificationImageDownloadURL,
      "licenseImageDownloadURL": licenseImageDownloadURL,
      "description": description,
      "isFormCompleted": isFormCompleted,
      "isGoogleUser": isGoogleUser,
      "isNormalUser": isNormalUser,
    };
  }
}

class Appointment {
  String? appointmentDate;
  String? timeSlot;
  bool? isPayment;
  String? transactionAmount;
  String? transactionDate;
  String? transactionTime;
  String? doctorUid;

  Appointment(
      {this.appointmentDate,
      this.isPayment,
      this.timeSlot,
      this.transactionAmount,
      this.transactionDate,
      this.transactionTime,
      this.doctorUid});

  factory Appointment.fromMap(map) {
    return Appointment(
        appointmentDate: map['apointment_date'],
        isPayment: map['isPaymentDone'],
        timeSlot: map['time_slot'],
        transactionDate: map['transaction_date'],
        transactionAmount: map['transaction_amount'],
        transactionTime: map['transaction_time'],
        doctorUid: map['doctor']);
  }
}
