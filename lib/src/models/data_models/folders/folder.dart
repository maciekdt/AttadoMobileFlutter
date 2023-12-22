class Folder {
  Folder({
    required this.folderId,
    required this.name,
    required this.folderNumber,
    required this.typeName,
    required this.statusName,
    required this.responsibleUserName,
    required this.responsibleUserFirstName,
    required this.responsibleUserSurname,
    required this.createUserFirstName,
    required this.createUserSurname,
    required this.createDate,
    required this.updateUserFirstName,
    required this.updateUserSurname,
    required this.updateDate,
    required this.signature,
    required this.extNumber,
    required this.startDate,
    required this.endDate,
    required this.priorityName,
    required this.projectValue,
    required this.chance,
    required this.storage,
    required this.contactFullName,
    required this.description,
  });

  int folderId;
  String name;
  String folderNumber;
  String typeName;
  String statusName;
  String responsibleUserName;
  String responsibleUserFirstName;
  String responsibleUserSurname;
  String createUserFirstName;
  String createUserSurname;
  DateTime createDate;
  String updateUserFirstName;
  String updateUserSurname;
  DateTime updateDate;
  String? signature;
  String? extNumber;
  DateTime? startDate;
  DateTime? endDate;
  String? priorityName;
  double? projectValue;
  int? chance;
  String? storage;
  String? contactFullName;
  String? description;

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      folderId: json["folderId"],
      name: json["name"],
      folderNumber: json["folderNumber"],
      typeName: json["typeName"],
      statusName: json["statusName"],
      responsibleUserName: json["responsibleUserName"],
      responsibleUserFirstName: json["responsibleUserFirstName"],
      responsibleUserSurname: json["responsibleUserSurname"],
      createUserFirstName: json["createUserFirstName"],
      createUserSurname: json["createUserSurname"],
      createDate: DateTime.parse(json["createDate"]),
      updateUserFirstName: json["updateUserFirstName"],
      updateUserSurname: json["updateUserSurname"],
      updateDate: DateTime.parse(json["updateDate"]),
      signature: json["signature"],
      extNumber: json["extNumber"],
      startDate:
          json["startDate"] != null ? DateTime.parse(json["startDate"]) : null,
      endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
      priorityName: json["priorityName"],
      projectValue: json["projectValue"],
      chance: json["chance"],
      storage: json["storage"],
      contactFullName: json["contactFullName"],
      description: json["description"],
    );
  }
}
