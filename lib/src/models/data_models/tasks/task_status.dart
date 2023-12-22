class TaskStatus {
  final int id;
  final String name;

  TaskStatus({
    required this.id,
    required this.name,
  });

  factory TaskStatus.fromJson(Map<String, dynamic> json) {
    return TaskStatus(
      id: json["id"],
      name: json["name"],
    );
  }
}
