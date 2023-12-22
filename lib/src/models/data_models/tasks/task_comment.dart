class TaskComment {
  final String username;
  final String firstName;
  final String surname;
  final String commentText;
  final DateTime savedOn;

  TaskComment({
    required this.username,
    required this.firstName,
    required this.surname,
    required this.commentText,
    required this.savedOn,
  });

  factory TaskComment.fromJson(Map<String, dynamic> json) {
    return TaskComment(
      username: json["username"],
      firstName: json["firstName"],
      surname: json["surname"],
      commentText: json["commentText"],
      savedOn: DateTime.parse(json["savedOn"]),
    );
  }
}
