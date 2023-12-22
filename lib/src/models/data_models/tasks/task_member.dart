class TaskMember {
  final int taskUserId;
  final String username;
  final String firstName;
  final String surname;

  TaskMember({
    required this.taskUserId,
    required this.username,
    required this.firstName,
    required this.surname,
  });

  factory TaskMember.fromJson(Map<String, dynamic> json) {
    return TaskMember(
      taskUserId: json["taskUserId"],
      username: json["username"],
      firstName: json["firstName"],
      surname: json["surname"],
    );
  }
}
