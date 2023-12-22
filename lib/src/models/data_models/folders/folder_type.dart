class FolderType {
  final int id;
  final String name;

  FolderType({
    required this.id,
    required this.name,
  });

  factory FolderType.fromJson(Map<String, dynamic> json) {
    return FolderType(
      id: json["id"],
      name: json["name"],
    );
  }
}
