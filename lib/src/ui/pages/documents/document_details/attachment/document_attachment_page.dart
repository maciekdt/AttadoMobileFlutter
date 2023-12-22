import 'dart:async';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/models/data_models/documents/document_attachment_file.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/dialogs/cancelable_loading_dialog.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/attachment/document_attachment_item.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/document_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class DocumentAttachmentPage extends StatefulWidget {
  const DocumentAttachmentPage({
    super.key,
    required this.documentsService,
    required this.document,
  });

  final DocumentsService documentsService;
  final Document document;

  @override
  State<StatefulWidget> createState() => _DocumentAttachmentPageState();
}

class _DocumentAttachmentPageState extends State<DocumentAttachmentPage>
    with AutomaticKeepAliveClientMixin<DocumentAttachmentPage> {
  late DocumentDetailsProvider _provider;

  Future<void> _refresh() async {
    await _provider.loadAttachment();
  }

  Future<void> _downloadAndOpenFile(DocumentAttachmentFile file) async {
    if (widget.document.fileName != null) {
      StreamSubscription<String> stream = widget.documentsService
          .downloadToTempAttachmentFile(file)
          .asStream()
          .listen(
        (String filePath) async {
          await OpenFile.open(filePath);
          _popLoadingDialog();
        },
      );
      _showLoadingDialog(stream);
    }
  }

  void _showLoadingDialog(StreamSubscription<String> stream) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return CancelableLoadingDialog(
          message: "Ściąganie pliku...",
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<DocumentDetailsProvider>(context);

    super.build(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: _provider.attachment == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _provider.attachment!.isEmpty
              ? Center(
                  child: Text(
                    "Brak elementów",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: _provider.attachment!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: DocumentAttachmentItem(
                        file: _provider.attachment![index],
                        downloadAndOpenFile: _downloadAndOpenFile,
                      ),
                    );
                  },
                ),
    );
  }
}
