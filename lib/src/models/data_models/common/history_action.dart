class HistoryAction {
  String username;
  String? firstName;
  String? surname;
  String actionType;
  String actionName;
  String? comment;
  DateTime savedOn;

  HistoryAction({
    required this.username,
    required this.firstName,
    required this.surname,
    required this.actionType,
    required this.actionName,
    required this.comment,
    required this.savedOn,
  });

  factory HistoryAction.fromJson(Map<String, dynamic> json) {
    return HistoryAction(
      username: json["username"],
      firstName:
          (json["firstName"] as String).isNotEmpty ? json["firstName"] : null,
      surname: (json["surname"] as String).isNotEmpty ? json["surname"] : null,
      actionType: json["actionType"],
      actionName: json["actionName"],
      comment: json["comment"],
      savedOn: DateTime.parse(json["savedOn"]),
    );
  }
}
