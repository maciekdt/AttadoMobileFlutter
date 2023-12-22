import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/ui/common/containers/rounded_text_label.dart';
import 'package:attado_mobile/src/ui/pages/documents/providers/selected_documents_provider.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DocumentsListItem extends StatefulWidget {
  const DocumentsListItem({
    super.key,
    required this.document,
    this.selectable = true,
    this.isMainList = true,
  });
  final Document document;
  final bool selectable;
  final bool isMainList;

  @override
  State<DocumentsListItem> createState() => _DocumentsListItemState();
}

class _DocumentsListItemState extends State<DocumentsListItem> {
  late SelectedDocumentsProvider _selectionProvider;

  void _onTap() async {
    if (_selectionProvider.selectedDocuments.isEmpty) {
      //_appProvider.showBottomNavigation = false;
      await context.push("/documents/details", extra: widget.document);
      //if (widget.isMainList) _appProvider.showBottomNavigation = true;
    } else if (widget.selectable) {
      _select();
    }
  }

  void _select() {
    if (_selectionProvider.isDocumentSelected(widget.document)) {
      _selectionProvider.unselectDocument(widget.document);
    } else {
      _selectionProvider.selectDocument(widget.document);
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectionProvider = Provider.of<SelectedDocumentsProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
        color: _selectionProvider.isDocumentSelected(widget.document)
            ? Theme.of(context).colorScheme.surfaceVariant
            : null,
        child: InkWell(
          onTap: _onTap,
          onLongPress: widget.selectable ? _select : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _selectionProvider.isDocumentSelected(widget.document)
                        ? CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.description_outlined,
                            size: 40,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.documentLight
                                    : AppColors.documentDark,
                          ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 270,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.document.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2.5),
                        Row(
                          children: [
                            Text(
                              widget.document.documentNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 13),
                            ),
                            const SizedBox(width: 0),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: CircleAvatar(
                                maxRadius: 8,
                                backgroundColor: widget.document.isLast
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : Theme.of(context).colorScheme.error,
                                child: Text(
                                  'v${widget.document.versionNumber}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontSize: 9),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.document.typeName,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 12),
                        ),
                        const SizedBox(height: 4.5),
                        SizedBox(
                          child: RoundedTextLabel(
                            text: widget.document.workflowStateName,
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.documentConLight
                                    : AppColors.documentConDark,
                            icon: Icons.content_paste_search_outlined,
                            maxWidth: 200,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
