class TaskPriority {
  final int id;
  final String name;

  TaskPriority({
    required this.id,
    required this.name,
  });

  factory TaskPriority.fromJson(Map<String, dynamic> json) {
    return TaskPriority(
      id: json["id"],
      name: json["name"],
    );
  }
}
