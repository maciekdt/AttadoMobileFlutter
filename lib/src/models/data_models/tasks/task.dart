class Task {
  Task({
    required this.taskId,
    required this.name,
    required this.statusName,
    required this.priorityName,
    required this.startDate,
    required this.typeName,
    required this.contactFullName,
    required this.endDate,
    required this.description,
    required this.location,
    required this.createUserFirstName,
    required this.createUserSurname,
    required this.createDate,
    required this.updateUserFirstName,
    required this.updateUserSurname,
    required this.updateDate,
  });

  int taskId;
  String name;
  String statusName;
  String? priorityName;
  DateTime startDate;
  String typeName;
  String? contactFullName;
  DateTime endDate;
  String? description;
  String? location;
  String createUserFirstName;
  String createUserSurname;
  DateTime createDate;
  String updateUserFirstName;
  String updateUserSurname;
  DateTime updateDate;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json["taskId"],
      name: json["name"],
      statusName: json["statusName"],
      priorityName: json["priorityName"],
      startDate: DateTime.parse(json["startDate"]),
      typeName: json["typeName"],
      contactFullName: json["contactFullName"],
      endDate: DateTime.parse(json["endDate"]),
      description: json["description"],
      location: json["location"],
      createUserFirstName: json["createUserFirstName"],
      createUserSurname: json["createUserSurname"],
      createDate: DateTime.parse(json["createDate"]),
      updateUserFirstName: json["updateUserFirstName"],
      updateUserSurname: json["updateUserSurname"],
      updateDate: DateTime.parse(json["updateDate"]),
    );
  }
}
