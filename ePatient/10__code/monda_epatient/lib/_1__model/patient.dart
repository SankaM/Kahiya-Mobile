import 'package:monda_epatient/_1__model/doctor.dart';

class Patient {
  String id;

  Doctor? doctor;

  String? firstName;

  String? lastName;

  String? birthDate;

  String? gender;

  String? mobilePhone;

  String? healthProfile;

  String? nic;

  String? imageUrl;

  String? userName;

  bool? isActive;

  String? email;

  String? currentDiagnosis;

  int? get age {
    if(birthDate != null) {
      var now = DateTime.now();
      var birthDateAsDateTime = DateTime.parse(birthDate!);

      return (now.difference(birthDateAsDateTime).inDays / 365).floor();
    }

    return null;
  }

  String get name {
    String name = (this.firstName != null ? (this.firstName! + ' ') : '');
    name += (this.lastName != null ? this.lastName! : '');

    return name;
  }

  String get genderNonNull {
    return gender == null ? '' : gender!;
  }

  String get healthProfileNonNull {
    return healthProfile == null ? '' : healthProfile!;
  }

  Patient({
    required this.id,
    this.doctor,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.mobilePhone,
    this.healthProfile,
    this.nic,
    this.imageUrl,
    this.userName,
    this.isActive,
    this.email,
    this.currentDiagnosis,
  });

  factory Patient.buildDetail(Map<String, dynamic> json) => Patient(
    id: json['id'],
    doctor: json['doctor'] != null ? Doctor.buildDetail(json['doctor']) : null,
    firstName: json['firstName'],
    lastName: json['lastName'],
    birthDate: json['birthDate'],
    gender: json['gender'],
    mobilePhone: json['mobilePhone'],
    healthProfile: json['healthProfile'],
    nic: json['nic'],
    imageUrl: json['imageUrl'],
    userName: json['userName'],
    isActive: json['isActive'],
    email: json['email'],
    currentDiagnosis: json['currentDiagnosis'],
  );
}
