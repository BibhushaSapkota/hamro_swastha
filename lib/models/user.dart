class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
  });

  // Receiving Data from Server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  // Sending Data to the Server
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}

class DoctorModel {
  String? docid;
  String? email;
  String? firstName;
  String? lastName;

  DoctorModel({
    this.docid,
    this.email,
    this.firstName,
    this.lastName,
  });

  // Receiving Data from Server
  factory DoctorModel.fromMap(map) {
    return DoctorModel(
      docid: map['docid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  // Sending Data to the Server
  Map<String, dynamic> toMap() {
    return {
      "docid": docid,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}
