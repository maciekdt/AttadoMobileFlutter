import 'dart:async';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/document_details_provider.dart';
import 'package:attado_mobile/src/ui/common/list_items/history_action_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentHistoryPage extends StatefulWidget {
  const DocumentHistoryPage({
    super.key,
    required this.documentsService,
    required this.document,
  });

  final DocumentsService documentsService;
  final Document document;

  @override
  State<StatefulWidget> createState() => _DocumentHistoryPageState();
}

class _DocumentHistoryPageState extends State<DocumentHistoryPage>
    with AutomaticKeepAliveClientMixin<DocumentHistoryPage> {
  late DocumentDetailsProvider _provider;

  Future<void> _refresh() async {
    await _provider.loadHistory();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<DocumentDetailsProvider>(context);

    super.build(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: _provider.history == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _provider.history!.isEmpty
              ? Center(
                  child: Text(
                    "Brak elementów",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: _provider.history!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        index == 0
                            ? const Column(
                                children: [
                                  SizedBox(height: 1),
                                  DetailsDivider(),
                                ],
                              )
                            : const SizedBox(),
                        HistoryActionItem(action: _provider.history![index]),
                        const DetailsDivider(),
                      ],
                    );
                  },
                ),
    );
  }
}
