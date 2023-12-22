class ContactType {
  final int id;
  final String name;
  final bool isContactGroup;
  final bool isPerson;
  final bool isCompany;
  final bool isCompanyBranch;
  final bool isCompanyAddress;

  ContactType({
    required this.id,
    required this.name,
    required this.isCompany,
    required this.isPerson,
    required this.isContactGroup,
    required this.isCompanyAddress,
    required this.isCompanyBranch,
  });

  factory ContactType.fromJson(Map<String, dynamic> json) {
    return ContactType(
      id: json["id"],
      name: json["name"],
      isCompany: json["isCompany"],
      isPerson: json["isPerson"],
      isContactGroup: json["isContactGroup"],
      isCompanyAddress: json["isCompanyAddress"],
      isCompanyBranch: json["isCompanyBranch"],
    );
  }
}
