import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/common/list_items/reletad_object_group_item.dart';
import 'package:attado_mobile/src/ui/pages/contacts/contact_details/contact_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ContactRelatedObjectsPage extends StatefulWidget {
  const ContactRelatedObjectsPage({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  State<StatefulWidget> createState() => _ContactRelatedObjectsPageState();
}

class _ContactRelatedObjectsPageState extends State<ContactRelatedObjectsPage>
    with AutomaticKeepAliveClientMixin<ContactRelatedObjectsPage> {
  late ContactDetailsProvider _provider;

  void _goToRelDocuments() {
    context.push("/rel-documents", extra: {
      'documents': _provider.relDocuments!,
      'title': widget.contact.shortName,
    });
  }

  void _goToRelFolders() {
    context.push("/rel-folders", extra: {
      'folders': _provider.relFolders!,
      'title': widget.contact.shortName,
    });
  }

  void _goToRelContacts() {
    context.push("/rel-contacts", extra: {
      'contacts': _provider.relContacts!,
      'title': widget.contact.fullName,
    });
  }

  void _goToRelTasks() {
    context.push("/rel-tasks", extra: {
      'tasks': _provider.relTasks!,
      'title': widget.contact.shortName,
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ContactDetailsProvider>(context);

    super.build(context);
    return !_provider.relLoaded
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              RelatedObjectGroupItem(
                title: "eDokumenty",
                icon: Icons.description_outlined,
                relatedNumber: _provider.relDocuments!.length,
                onTap: _goToRelDocuments,
              ),
              const DetailsDivider(),
              RelatedObjectGroupItem(
                title: "eSprawy",
                icon: Icons.folder_outlined,
                relatedNumber: _provider.relFolders!.length,
                onTap: _goToRelFolders,
              ),
              const DetailsDivider(),
              RelatedObjectGroupItem(
                title: "eKontakty",
                icon: Icons.person_outline,
                relatedNumber: _provider.relContacts!.length,
                onTap: _goToRelContacts,
              ),
              const DetailsDivider(),
              RelatedObjectGroupItem(
                title: "Zadania",
                icon: Icons.task_alt,
                relatedNumber: _provider.relTasks!.length,
                onTap: _goToRelTasks,
              ),
              const DetailsDivider(),
            ],
          );
  }
}
