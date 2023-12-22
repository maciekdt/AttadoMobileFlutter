import 'dart:async';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/common/list_items/history_action_item.dart';
import 'package:attado_mobile/src/ui/pages/folders/folder_details/folder_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FolderHistoryPage extends StatefulWidget {
  const FolderHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _FolderHistoryPageState();
}

class _FolderHistoryPageState extends State<FolderHistoryPage>
    with AutomaticKeepAliveClientMixin<FolderHistoryPage> {
  late FolderDetailsProvider _provider;

  Future<void> _refresh() async {
    await _provider.loadHistory();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<FolderDetailsProvider>(context);

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
                        HistoryActionItem(action: _provider.history![index]),
                        const DetailsDivider(),
                      ],
                    );
                  },
                ),
    );
  }
}
