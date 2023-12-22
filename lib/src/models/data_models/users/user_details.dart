class UserDetails {
  String id;

  UserDetails({
    required this.id,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json["id"],
    );
  }
}
