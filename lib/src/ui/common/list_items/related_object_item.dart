// ignore_for_file: use_build_context_synchronously
import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/common/item_type.dart';
import 'package:attado_mobile/src/models/data_models/common/related_item.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/services/contacts_service.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:attado_mobile/src/ui/common/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RelatedObjectItem extends StatefulWidget {
  const RelatedObjectItem({
    super.key,
    required this.item,
  });

  final RelatedItem item;

  @override
  State<StatefulWidget> createState() => _RelatedObjectItemState();
}

class _RelatedObjectItemState extends State<RelatedObjectItem> {
  Future<void> _goToRelated() async {
    _showLoadingDialog();
    switch (widget.item.type) {
      case ItemType.document:
        {
          Document document =
              await getIt<DocumentsService>().getDocument(widget.item.id);
          _hideLoadingDialog();
          context.push("/documents/details", extra: document);
        }
      case ItemType.folder:
        {
          Folder folder =
              await getIt<FoldersService>().getFolder(widget.item.id);
          _hideLoadingDialog();
          context.push("/folders/details", extra: folder);
        }
      case ItemType.contact:
        {
          Contact contact =
              await getIt<ContactsService>().getContact(widget.item.id);
          _hideLoadingDialog();
          context.push("/contacts/details", extra: contact);
        }
      case ItemType.task:
        {
          Task task = await getIt<TasksService>().getTask(widget.item.id);
          _hideLoadingDialog();
          context.push("/tasks/details", extra: task);
        }
    }
  }

  void _showLoadingDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const LoadingDialog(message: "Ładowanie...");
        });
  }

  void _hideLoadingDialog() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _goToRelated,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(_getIcon(), size: 28),
            const SizedBox(width: 15),
            SizedBox(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  widget.item.number != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            widget.item.number!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (widget.item.type) {
      case ItemType.document:
        return Icons.description_outlined;
      case ItemType.folder:
        return Icons.folder_outlined;
      case ItemType.contact:
        return Icons.person_outlined;
      case ItemType.task:
        return Icons.task_alt_outlined;
    }
  }
}
