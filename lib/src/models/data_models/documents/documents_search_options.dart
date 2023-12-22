class DocumentsSearchOptions {
  String? name;
  String? documentNumber;
  int? workFlowStateId;
  int? typeId;
  String? fileKind;
  String? createUserId;
  String? description;
  bool onlyLast;
  String? filter;
  int? relDocumentId;
  int? relFolderId;

  DocumentsSearchOptions({
    this.name,
    this.documentNumber,
    this.workFlowStateId,
    this.typeId,
    this.fileKind,
    this.createUserId,
    this.description,
    this.onlyLast = false,
    this.filter,
    this.relDocumentId,
    this.relFolderId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'documentNumber': documentNumber,
        'workFlowStateId': workFlowStateId,
        'typeId': typeId,
        'fileKind': fileKind,
        'createUserId': createUserId,
        'description': description,
        'onlyLast': onlyLast,
        'filter': filter,
        'relDocumentId': relDocumentId,
        'relFolderId': relFolderId,
      };

  DocumentsSearchOptions clone() => DocumentsSearchOptions(
        name: name,
        documentNumber: documentNumber,
        workFlowStateId: workFlowStateId,
        typeId: typeId,
        fileKind: fileKind,
        createUserId: createUserId,
        description: description,
        onlyLast: onlyLast,
        filter: filter,
        relDocumentId: relDocumentId,
        relFolderId: relFolderId,
      );
}
