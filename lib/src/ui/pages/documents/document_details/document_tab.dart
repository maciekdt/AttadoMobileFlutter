import 'dart:async';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/common/tabs/tab_with_counter.dart';
import 'package:attado_mobile/src/ui/common/dialogs/cancelable_loading_dialog.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/attachment/document_attachment_page.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/details/document_detail_page.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/history/document_history_page.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/versions/document_versions_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'document_details_provider.dart';
import 'related/document_related_objects_page.dart';

class DocumentTab extends StatefulWidget {
  const DocumentTab({
    super.key,
    required this.document,
    required this.documentsService,
  });

  final Document document;
  final DocumentsService documentsService;

  @override
  State<DocumentTab> createState() => _DocumentTabState();
}

enum ActionsMenu {
  download,
  share,
}

class _DocumentTabState extends State<DocumentTab> {
  @override
  initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).showBottomNavigation =
        false;
  }

  Future<void> _downloadAndOpenFile() async {
    if (widget.document.fileName != null) {
      StreamSubscription<String> stream = widget.documentsService
          .downloadToTempFile(
            widget.document.documentId,
            widget.document.fileName as String,
          )
          .asStream()
          .listen(
        (String filePath) async {
          await OpenFile.open(filePath);
          _popLoadingDialog();
        },
      );
      _showLoadingDialog(stream, "Ściąganie pliku...");
    }
  }

  Future<void> _share() async {
    StreamSubscription<List<String>> stream = widget.documentsService
        .downloadToTempDocument(widget.document)
        .asStream()
        .listen(
      (List<String> paths) async {
        List<XFile> xFiles = paths.map((path) => XFile(path)).toList();
        await Share.shareXFiles(xFiles, subject: widget.document.name);
        _popLoadingDialog();
      },
    );
    _showLoadingDialog(stream, "Udostępnianie plików...");
  }

  void _showLoadingDialog(
    StreamSubscription<Object> stream,
    String message,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return CancelableLoadingDialog(
          message: message,
          onCancel: () {
            stream.cancel();
            _popLoadingDialog();
          },
        );
      },
    );
  }

  void _popLoadingDialog() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DocumentDetailsProvider(document: widget.document),
      child: Consumer<DocumentDetailsProvider>(
        builder: (context, provider, child) => DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 40,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 3, top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.document.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 14.5),
                    ),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        Text(
                          widget.document.documentNumber,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: CircleAvatar(
                            maxRadius: 9,
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
                                  ?.copyWith(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                PopupMenuButton<ActionsMenu>(
                  onSelected: (ActionsMenu result) async {
                    switch (result) {
                      case ActionsMenu.download:
                        await _downloadAndOpenFile();
                        break;
                      case ActionsMenu.share:
                        await _share();
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<ActionsMenu>>[
                    const PopupMenuItem<ActionsMenu>(
                      value: ActionsMenu.download,
                      child: Row(
                        children: [
                          Icon(Icons.download),
                          SizedBox(width: 10),
                          Text("Pobierz plik"),
                        ],
                      ),
                    ),
                    const PopupMenuItem<ActionsMenu>(
                      value: ActionsMenu.share,
                      child: Row(
                        children: [
                          Icon(Icons.share_outlined),
                          SizedBox(width: 10),
                          Text("Udostępnij"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              bottom: TabBar(
                indicatorColor: Theme.of(context).colorScheme.primary,
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                tabs: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.5),
                    child: Tab(
                      icon: Icon(Icons.description_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.5, right: 7.5),
                    child: TabWithCounter(
                      label: "Wersje",
                      value: provider.versions?.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.5, right: 7.5),
                    child: TabWithCounter(
                      label: "Pliki dodatkowe",
                      value: provider.attachment?.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.5, right: 7.5),
                    child: TabWithCounter(
                      label: "Powiązane",
                      value: provider.relNumber,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.5, right: 5),
                    child: TabWithCounter(
                      label: "Historia",
                      value: provider.history?.length,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                DocumentDetailPage(
                  document: widget.document,
                  downloadAndOpenFile: _downloadAndOpenFile,
                ),
                DocumentVersionsPage(
                  documentsService: widget.documentsService,
                  document: widget.document,
                ),
                DocumentAttachmentPage(
                  document: widget.document,
                  documentsService: widget.documentsService,
                ),
                DocumentRelatedObjectsPage(
                  document: widget.document,
                  documentsService: widget.documentsService,
                ),
                DocumentHistoryPage(
                  documentsService: widget.documentsService,
                  document: widget.document,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
