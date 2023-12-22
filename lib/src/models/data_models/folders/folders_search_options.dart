class FoldersSearchOptions {
  String? name;
  String? folderNumber;
  String? description;
  String? contactFullName;
  String? createUserId;
  String? responsibleUserId;
  int? typeId;
  int? statusId;

  FoldersSearchOptions({
    this.name,
    this.folderNumber,
    this.description,
    this.contactFullName,
    this.createUserId,
    this.responsibleUserId,
    this.typeId,
    this.statusId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'folderNumber': folderNumber,
        'description': description,
        'contactFullName': contactFullName,
        'createUserId': createUserId,
        'responsibleUserId': responsibleUserId,
        'typeId': typeId,
        'statusId': statusId,
      };

  FoldersSearchOptions clone() => FoldersSearchOptions(
        name: name,
        folderNumber: folderNumber,
        description: description,
        typeId: typeId,
        contactFullName: contactFullName,
        createUserId: createUserId,
        responsibleUserId: description,
        statusId: statusId,
      );
}
