class DocumentState {
  int id;
  String name;
  bool startingState;
  bool lastState;
  bool userActionRequired;

  DocumentState({
    required this.id,
    required this.name,
    required this.startingState,
    required this.lastState,
    required this.userActionRequired,
  });

  factory DocumentState.fromJson(Map<String, dynamic> json) {
    return DocumentState(
      id: json["id"],
      name: json["name"],
      startingState: json["startingState"],
      lastState: json["lastState"],
      userActionRequired: json["userActionRequired"],
    );
  }
}
