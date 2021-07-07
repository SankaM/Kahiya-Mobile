class Patient {
  String patientId;

  String? doctorId;

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

  int? get age {
    if(birthDate != null) {
      var now = DateTime.now();
      var birthDateAsDateTime = DateTime.parse(birthDate!);

      return (now.difference(birthDateAsDateTime).inDays / 365).floor();
    }

    return null;
  }

  Patient(
      {required this.patientId,
      this.doctorId,
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
      this.email});
}
