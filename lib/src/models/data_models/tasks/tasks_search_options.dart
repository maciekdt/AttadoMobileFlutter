class TasksSearchOptions {
  String? name;
  String? description;
  String? contactFullName;
  int? typeId;
  int? statusId;
  int? priorityId;
  String? createUserId;
  String? filter;

  TasksSearchOptions({
    this.name,
    this.description,
    this.contactFullName,
    this.typeId,
    this.statusId,
    this.priorityId,
    this.createUserId,
    this.filter,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'contactFullName': contactFullName,
        'typeId': typeId,
        'statusId': statusId,
        'priorityId': priorityId,
        'createUserId': createUserId,
        'filter': filter,
      };

  TasksSearchOptions clone() => TasksSearchOptions(
        name: name,
        contactFullName: contactFullName,
        description: description,
        typeId: typeId,
        priorityId: priorityId,
        createUserId: createUserId,
        filter: createUserId,
      );
}
