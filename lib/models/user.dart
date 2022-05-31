class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  bool? isPatient;
  String? password;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.isPatient,
  });

  // Receiving Data from Server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        password: map['password'],
        isPatient: map['isPatient']);
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

  DoctorModel({
    this.docid,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.isDoctor,
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
    };
  }
}
