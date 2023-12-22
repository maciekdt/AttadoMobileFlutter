import 'package:attado_mobile/src/models/data_models/contacts/contact_type.dart';
import 'package:attado_mobile/src/services/contacts_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactTypeSearchPage extends StatefulWidget {
  const ContactTypeSearchPage({
    super.key,
    required this.contactsService,
  });

  final ContactsService contactsService;

  @override
  State<ContactTypeSearchPage> createState() => _ContactTypeSearchPageState();
}

class _ContactTypeSearchPageState extends State<ContactTypeSearchPage> {
  List<ContactType> _filterData(List<ContactType> types, String? pattern) {
    if (pattern == null) return types;
    pattern = pattern.toLowerCase();
    return types
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(ContactType type) {
    context.pop(type);
  }

  Widget _getTypeIcon(ContactType type) {
    if (type.isPerson) {
      return const Icon(Icons.person_outlined);
    } else if (type.isCompany) {
      return const Icon(Icons.apartment_outlined);
    } else if (type.isContactGroup) {
      return const Icon(Icons.groups_outlined);
    } else if (type.isCompanyAddress) {
      return const Icon(Icons.location_on_outlined);
    } else if (type.isCompanyBranch) {
      return const Icon(Icons.apartment_outlined);
    }
    return const Icon(Icons.psychology_alt_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<ContactType>(
      fetchData: widget.contactsService.getContactsTypes(),
      filterData: _filterData,
      listTileBuilder: (ContactType type) => ListTile(
        leading: _getTypeIcon(type),
        title: Text(type.name),
        onTap: () => _onSelected(type),
      ),
    );
  }
}
