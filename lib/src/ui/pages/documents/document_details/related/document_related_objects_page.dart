import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/document_details_provider.dart';
import 'package:attado_mobile/src/ui/common/list_items/reletad_object_group_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DocumentRelatedObjectsPage extends StatefulWidget {
  const DocumentRelatedObjectsPage({
    super.key,
    required this.document,
    required this.documentsService,
  });

  final Document document;
  final DocumentsService documentsService;

  @override
  State<StatefulWidget> createState() => _DocumentRelatedObjectsPageState();
}

class _DocumentRelatedObjectsPageState extends State<DocumentRelatedObjectsPage>
    with AutomaticKeepAliveClientMixin<DocumentRelatedObjectsPage> {
  late DocumentDetailsProvider _provider;

  void _goToRelDocuments() {
    context.push("/rel-documents", extra: {
      'documents': _provider.relDocuments!,
      'title': widget.document.name,
    });
  }

  void _goToRelFolders() {
    context.push("/rel-folders", extra: {
      'folders': _provider.relFolders!,
      'title': widget.document.name,
    });
  }

  void _goToRelContacts() {
    context.push("/rel-contacts", extra: {
      'contacts': _provider.relContacts!,
      'title': widget.document.name,
    });
  }

  void _goToRelTasks() {
    context.push("/rel-tasks", extra: {
      'tasks': _provider.relTasks!,
      'title': widget.document.name,
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<DocumentDetailsProvider>(context);

    super.build(context);
    return !_provider.relLoaded
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              const SizedBox(height: 1),
              const DetailsDivider(),
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
