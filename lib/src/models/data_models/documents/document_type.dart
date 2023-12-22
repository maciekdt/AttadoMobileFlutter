class DocumentType {
  final int id;
  final String name;
  final bool isDefault;
  final String? subFormType;
  final bool enabled;

  DocumentType({
    required this.id,
    required this.name,
    required this.isDefault,
    required this.subFormType,
    required this.enabled,
  });

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      id: json["id"],
      name: json["name"],
      isDefault: json["isDefault"],
      subFormType: json["subFormType"],
      enabled: json["enabled"],
    );
  }
}
