class TaskType {
  final int id;
  final String name;

  TaskType({
    required this.id,
    required this.name,
  });

  factory TaskType.fromJson(Map<String, dynamic> json) {
    return TaskType(
      id: json["id"],
      name: json["name"],
    );
  }
}
