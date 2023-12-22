import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/common/list_items/reletad_object_group_item.dart';
import 'package:attado_mobile/src/ui/pages/folders/folder_details/folder_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FolderRelatedObjectsPage extends StatefulWidget {
  const FolderRelatedObjectsPage({
    super.key,
    required this.folder,
  });

  final Folder folder;

  @override
  State<StatefulWidget> createState() => _FolderRelatedObjectsPageState();
}

class _FolderRelatedObjectsPageState extends State<FolderRelatedObjectsPage>
    with AutomaticKeepAliveClientMixin<FolderRelatedObjectsPage> {
  late FolderDetailsProvider _provider;

  void _goToRelDocuments() {
    context.push("/rel-documents", extra: {
      'documents': _provider.relDocuments!,
      'title': widget.folder.name,
    });
  }

  void _goToRelFolders() {
    context.push("/rel-folders", extra: {
      'folders': _provider.relFolders!,
      'title': widget.folder.name,
    });
  }

  void _goToRelContacts() {
    context.push("/rel-contacts", extra: {
      'contacts': _provider.relContacts!,
      'title': widget.folder.name,
    });
  }

  void _goToRelTasks() {
    context.push("/rel-tasks", extra: {
      'tasks': _provider.relTasks!,
      'title': widget.folder.name,
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<FolderDetailsProvider>(context);

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
