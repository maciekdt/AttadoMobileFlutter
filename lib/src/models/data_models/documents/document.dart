class Document {
  final int documentId;
  final String name;
  final String documentNumber;
  final int versionNumber;
  final String? versionDescription;
  final bool isLast;
  final int workflowStateId;
  final String workflowStateName;
  final String typeName;
  final String? fileName;
  final String responsibleUserName;
  final String responsibleUserFirstName;
  final String responsibleUserSurname;
  final DateTime createDate;
  final String createUserName;
  final String createUserFirstName;
  final String createUserSurname;
  final DateTime updateDate;
  final String updateUserName;
  final String updateUserFirstName;
  final String updateUserSurname;
  final DateTime? fileUpdateDate;
  final String? description;
  final String? storage;
  final String? extNumber;
  final DateTime? validTo;
  final String? signature;

  Document({
    required this.documentId,
    required this.name,
    required this.documentNumber,
    required this.versionNumber,
    required this.versionDescription,
    required this.isLast,
    required this.workflowStateId,
    required this.workflowStateName,
    required this.typeName,
    required this.fileName,
    required this.responsibleUserName,
    required this.responsibleUserFirstName,
    required this.responsibleUserSurname,
    required this.createDate,
    required this.createUserName,
    required this.createUserFirstName,
    required this.createUserSurname,
    required this.updateDate,
    required this.updateUserName,
    required this.updateUserFirstName,
    required this.updateUserSurname,
    required this.fileUpdateDate,
    required this.description,
    required this.storage,
    required this.extNumber,
    required this.validTo,
    required this.signature,
  });

  @override
  bool operator ==(Object other) {
    return other is Document && other.documentId == documentId;
  }

  @override
  int get hashCode => documentId.hashCode;

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      documentId: json["documentId"],
      name: json["name"],
      documentNumber: json["documentNumber"],
      versionNumber: json["versionNumber"],
      isLast: json["isLast"],
      workflowStateId: json["workflowStateId"],
      workflowStateName: json["workflowStateName"],
      typeName: json["typeName"],
      fileName: json["fileName"],
      responsibleUserSurname: json["responsibleUserSurname"],
      responsibleUserFirstName: json["responsibleUserFirstName"],
      responsibleUserName: json["responsibleUserName"],
      createDate: DateTime.parse(json["createDate"]),
      createUserName: json["createUserName"],
      createUserFirstName: json["createUserFirstName"],
      createUserSurname: json["createUserSurname"],
      updateDate: DateTime.parse(json["updateDate"]),
      updateUserName: json["updateUserName"],
      updateUserFirstName: json["updateUserFirstName"],
      updateUserSurname: json["updateUserSurname"],
      fileUpdateDate: json["fileUpdateDate"] != null
          ? DateTime.parse(json["fileUpdateDate"])
          : null,
      description: json["description"] != null &&
              (json["description"] as String).isNotEmpty
          ? json["description"]
          : null,
      storage: json["storage"] != null && (json["storage"] as String).isNotEmpty
          ? json["storage"]
          : null,
      extNumber:
          json["extNumber"] != null && (json["extNumber"] as String).isNotEmpty
              ? json["extNumber"]
              : null,
      validTo: json["validTo"] != null ? DateTime.parse(json["validTo"]) : null,
      signature:
          json["signature"] != null && (json["signature"] as String).isNotEmpty
              ? json["signature"]
              : null,
      versionDescription: json["versionDescription"] != null &&
              (json["versionDescription"] as String).isNotEmpty
          ? json["versionDescription"]
          : null,
    );
  }
}
