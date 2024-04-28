class User {
  final String name;
  final String email;
  final String uid;
  final String profilePhoto;
  final double points;
  final int donations;

  const User({
    required this.name,
    required this.email,
    required this.uid,
    this.profilePhoto =
        "https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg",
    this.donations = 0,
    this.points = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      profilePhoto: json['profilePhoto'],
      points: double.parse(json['points'].toString()),
      donations: json['donations'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'profilePhoto': profilePhoto,
      'points': points,
      'donations': donations,
    };
  }
}
