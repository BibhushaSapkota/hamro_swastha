class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  bool? isPatient;
  String? password;
  bool? isFormCompleted;
  String? profilePicture;
  String? gender;
  String? contact;
  String? date;
  String? oldReportFile;

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
  });

  // Receiving Data from Server
  factory UserModel.fromMap(map) {
    return UserModel(
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
        date: map['date'],
        oldReportFile: map['oldReportFile']);
  }

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
      'date': date,
      'oldReportFile': oldReportFile
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

  DoctorModel({
    this.docid,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.isDoctor,
    this.specialization,
    this.position,
    this.profileImageDownloadURL,
    this.identificationImageDownloadURL,
    this.licenseImageDownloadURL,
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
    };
  }
}
