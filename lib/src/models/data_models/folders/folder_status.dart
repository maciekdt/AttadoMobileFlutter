class FolderStatus {
  final int id;
  final String name;

  FolderStatus({
    required this.id,
    required this.name,
  });

  factory FolderStatus.fromJson(Map<String, dynamic> json) {
    return FolderStatus(
      id: json["id"],
      name: json["name"],
    );
  }
}
