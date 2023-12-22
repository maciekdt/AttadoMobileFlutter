class Contact {
  Contact({
    required this.shortName,
    required this.contactId,
    required this.kindName,
    required this.email,
    required this.mobilePhone,
    required this.city,
    required this.country,
    required this.phone,
    required this.postalCode,
    required this.street,
    required this.webSite,
    required this.responsibleUserFirstName,
    required this.responsibleUserSurname,
    required this.createUserFirstName,
    required this.createUserSurname,
    required this.createDate,
    required this.updateUserFirstName,
    required this.updateUserSurname,
    required this.updateDate,
    required this.taxNumber,
    required this.regonPesel,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.isCompany,
    required this.isPerson,
    required this.isContactGroup,
    required this.isCompanyAddress,
    required this.isCompanyBranch,
  });

  String? firstName;
  String? shortName;
  String? lastName;
  int contactId;
  String kindName;
  String? email;
  String? mobilePhone;
  String? phone;
  String? street;
  String? city;
  String? country;
  String? postalCode;
  String? webSite;
  String responsibleUserSurname;
  String responsibleUserFirstName;
  String createUserFirstName;
  String createUserSurname;
  DateTime createDate;
  String updateUserFirstName;
  String updateUserSurname;
  DateTime updateDate;
  String? taxNumber;
  String? regonPesel;
  String? description;
  final bool isContactGroup;
  final bool isPerson;
  final bool isCompany;
  final bool isCompanyBranch;
  final bool isCompanyAddress;

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      shortName: json["shortName"],
      contactId: json["contactId"],
      kindName: json["kindName"],
      email: json["email"],
      mobilePhone: json["mobilePhone"],
      phone: json["phone"],
      street: json["street"],
      city: json["city"],
      country: json["country"],
      postalCode: json["postalCode"],
      webSite: json["webSite"],
      responsibleUserFirstName: json["responsibleUserFirstName"],
      responsibleUserSurname: json["responsibleUserSurname"],
      createUserFirstName: json["createUserFirstName"],
      createUserSurname: json["createUserSurname"],
      createDate: DateTime.parse(json["createDate"]),
      updateUserFirstName: json["updateUserFirstName"],
      updateUserSurname: json["updateUserSurname"],
      updateDate: DateTime.parse(json["updateDate"]),
      taxNumber: json["taxNumber"],
      regonPesel: json["regonPesel"],
      description: json["description"],
      lastName: json["lastName"],
      firstName: json["firstName"],
      isCompany: json["isCompany"],
      isPerson: json["isPerson"],
      isContactGroup: json["isContactGroup"],
      isCompanyAddress: json["isCompanyAddress"],
      isCompanyBranch: json["isCompanyBranch"],
    );
  }

  String? get address {
    if (street == null || city == null) return null;
    return '${city!}, ${street!}';
  }

  String? get postalAddress {
    if (postalCode == null || country == null) return null;
    return '${postalCode!} ${country!}';
  }

  String get fullName {
    if (firstName != null && lastName != null) {
      return "$lastName $firstName";
    } else if (shortName != null) {
      return shortName!;
    }
    return "Brak nazwy";
  }
}
