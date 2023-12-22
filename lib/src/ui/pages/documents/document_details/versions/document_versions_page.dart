import 'dart:async';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/document_details_provider.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/versions/document_version_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentVersionsPage extends StatefulWidget {
  const DocumentVersionsPage({
    super.key,
    required this.documentsService,
    required this.document,
  });

  final DocumentsService documentsService;
  final Document document;

  @override
  State<StatefulWidget> createState() => _DocumentVesrsionsPageState();
}

class _DocumentVesrsionsPageState extends State<DocumentVersionsPage>
    with AutomaticKeepAliveClientMixin<DocumentVersionsPage> {
  late DocumentDetailsProvider _provider;

  Future<void> _refresh() async {
    await _provider.loadVersions();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<DocumentDetailsProvider>(context);

    super.build(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: _provider.versions == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _provider.versions!.isEmpty
              ? Center(
                  child: Text(
                    "Brak elementów",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: _provider.versions!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        DocumentVersionItem(
                            document: _provider.versions![index]),
                        const DetailsDivider(),
                      ],
                    );
                  },
                ),
    );
  }
}
