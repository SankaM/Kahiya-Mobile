class User {
  String id;

  String? firstName;

  String? lastName;

  String? userName;

  String? location;

  String? imageUrl;

  User({required this.id, this.firstName, this.lastName, this.userName, this.location, this.imageUrl});

  factory User.buildDetail(Map<String, dynamic> json) => User(
    id: json['patientId'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    userName: json['userName'],
    location: json['location'],
    imageUrl: json['imageUrl'],
  );

  String get name {
    String _name = '';

    if(firstName != null) {
      _name += (firstName! + ' ');
    }

    if(lastName != null) {
      _name += lastName!;
    }

    return _name;
  }
}
