class User {
  final String id;
  final String username;
  final String firstName;
  final String surname;
  final String jobTitle;
  final bool isActive;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.surname,
    required this.jobTitle,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      firstName: json["firstName"],
      surname: json["surname"],
      jobTitle: json["jobTitle"],
      isActive: json["isActive"],
    );
  }
}
