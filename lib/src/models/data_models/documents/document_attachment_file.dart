class DocumentAttachmentFile {
  final int documentAttachmentId;
  final int documentId;
  final String name;
  final String fileName;
  final String fileId;
  final DateTime fileUpdateDate;
  final String fileUpdateUserName;
  final String? fileUpdateUserFirstName;
  final String? fileUpdateUserSurname;

  DocumentAttachmentFile({
    required this.documentAttachmentId,
    required this.documentId,
    required this.name,
    required this.fileId,
    required this.fileUpdateDate,
    required this.fileUpdateUserName,
    required this.fileUpdateUserFirstName,
    required this.fileUpdateUserSurname,
    required this.fileName,
  });

  factory DocumentAttachmentFile.fromJson(Map<String, dynamic> json) {
    return DocumentAttachmentFile(
      documentAttachmentId: json["documentAttachmentId"],
      documentId: json["documentId"],
      name: json["name"],
      fileId: json["fileId"],
      fileUpdateDate: DateTime.parse(json["fileUpdateDate"]),
      fileUpdateUserName: json["fileUpdateUserName"],
      fileUpdateUserFirstName:
          (json["fileUpdateUserFirstName"] as String).isNotEmpty
              ? json["fileUpdateUserFirstName"]
              : null,
      fileUpdateUserSurname:
          (json["fileUpdateUserSurname"] as String).isNotEmpty
              ? json["fileUpdateUserSurname"]
              : null,
      fileName: json["fileName"],
    );
  }
}
