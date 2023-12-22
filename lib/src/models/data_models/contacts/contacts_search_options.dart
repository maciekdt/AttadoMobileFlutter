class ContactsSearchOptions {
  String? name;
  String? email;
  String? contactId;
  String? address;
  String? phone;
  String? description;
  String? createUserId;
  String? responsibleUserId;
  int? typeId;

  ContactsSearchOptions({
    this.name,
    this.email,
    this.contactId,
    this.address,
    this.phone,
    this.description,
    this.createUserId,
    this.responsibleUserId,
    this.typeId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'contactId': contactId,
        'city': address,
        'phone': phone,
        'description': description,
        'createUserId': createUserId,
        'responsibleUserId': responsibleUserId,
        'kindId': typeId,
      };

  ContactsSearchOptions clone() => ContactsSearchOptions(
        name: name,
        email: email,
        description: description,
        typeId: typeId,
        address: address,
        createUserId: createUserId,
        responsibleUserId: description,
        phone: phone,
      );
}
