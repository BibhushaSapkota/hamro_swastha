class Doctor {
  final String id;
  final String name;
  final String image;
  final String position;
  final String specialization;
  final String schedule;
  final String description;

  Doctor(
    this.id,
    this.name,
    this.image,
    this.position,
    this.specialization,
    this.schedule,
    this.description,
  );
}

class Doctors {
  String? id;
  Doctors({this.id});
}

class DoctorHistoryModel {
  String? id;
  String? name;
  String? image;
  String? position;
  String? specialization;
  String? schedule;
  String? description;

  DoctorHistoryModel(
      {this.id,
      this.name,
      this.image,
      this.position,
      this.specialization,
      this.schedule,
      this.description});

  factory DoctorHistoryModel.fromMap(map) {
    return DoctorHistoryModel(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        position: map['position'],
        specialization: map['specialization'],
        schedule: map['schedule'],
        description: map['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'position': position,
      'specialization': specialization,
      'schedule': schedule,
      'description': description
    };
  }
}

class Patient {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profileUrl;
  String? dateOfBirth;
  Patient(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.profileUrl,
      this.dateOfBirth});

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profileUrl': profileUrl,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory Patient.fromMap() {
    return Patient(
      id: 'uid',
      firstName: 'firstName',
      lastName: 'lastName',
      email: 'email',
      profileUrl: 'profileUrl',
      dateOfBirth: "dateOfBirth",
    );
  }
}
