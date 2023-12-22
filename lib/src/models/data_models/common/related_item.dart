import 'item_type.dart';

class RelatedItem {
  int id;
  String? number;
  String name;
  int? version;
  ItemType type;

  RelatedItem({
    required this.id,
    required this.number,
    required this.name,
    required this.version,
    required this.type,
  });

  factory RelatedItem.fromJson(Map<String, dynamic> json) {
    return RelatedItem(
      id: json["id"],
      number: json["number"],
      name: json["name"],
      version: json["version"],
      type: _encodeType(json["type"] as int),
    );
  }

  static ItemType _encodeType(int typeId) {
    switch (typeId) {
      case 1:
        return ItemType.document;
      case 2:
        return ItemType.folder;
      case 3:
        return ItemType.contact;
      default:
        return ItemType.task;
    }
  }
}
