class Doctor {
  final String id;
  final String name;
  final String image;
  final String orgName;
  final String specialization;
  final String schedule;
  final String description;

  Doctor(
    this.id,
    this.name,
    this.image,
    this.orgName,
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
  String? orgName;
  String? specialization;
  String? schedule;
  String? description;

  DoctorHistoryModel(
      {this.id,
      this.name,
      this.image,
      this.orgName,
      this.specialization,
      this.schedule,
      this.description});

  factory DoctorHistoryModel.fromMap(map) {
    return DoctorHistoryModel(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        orgName: map['orgName'],
        specialization: map['specialization'],
        schedule: map['schedule'],
        description: map['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'orgName': orgName,
      'specialization': specialization,
      'schedule': schedule,
      'description': description
    };
  }
}
