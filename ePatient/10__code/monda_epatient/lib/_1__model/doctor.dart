class Doctor {
  final String id;

  final String? name;

  final String? gender;

  final String? speciality;

  final String? profile;

  final String? generalWorkHour;

  final String? mobilePhone;

  final String? email;

  final String? address1;

  final String? address2;

  final String? address3;

  final String? zipCode;

  final String? imageUrl;

  final String? userName;

  final bool? isActive;

  final double? doctorCost;

  Doctor({
    required this.id,
    this.name,
    this.gender,
    this.speciality,
    this.profile,
    this.generalWorkHour,
    this.mobilePhone,
    this.email,
    this.address1,
    this.address2,
    this.address3,
    this.zipCode,
    this.imageUrl,
    this.userName,
    this.isActive,
    this.doctorCost,
  });

  factory Doctor.buildDetail(Map<String, dynamic> json) => Doctor(
    id: json['id'],
    name: json['name'],
    gender: json['gender'],
    speciality: json['speciality'],
    profile: json['profile'],
    generalWorkHour: json['generalWorkHour'],
    mobilePhone: json['mobilePhone'],
    email: json['email'],
    address1: json['address1'],
    address2: json['address2'],
    address3: json['address3'],
    zipCode: json['zipCode'],
    imageUrl: json['imageUrl'],
    userName: json['userName'],
    isActive: json['isActive'],
    doctorCost: json['doctorCost'],
  );
}
