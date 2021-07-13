

class User {
  String id;

  String? name;

  String? userName;

  String? location;

  String? imageUrl;

  User({required this.id, this.name, this.userName, this.location, this.imageUrl});

  factory User.buildDetail(Map<String, dynamic> json) => User(
      id: json['doctorId'],
      name: json['doctorName'],
      userName: json['userName'],
      location: json['location'],
      imageUrl: json['imageUrl'],);
}
