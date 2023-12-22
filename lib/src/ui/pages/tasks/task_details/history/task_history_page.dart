import 'dart:async';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/common/list_items/history_action_item.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/task_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskHistoryPage extends StatefulWidget {
  const TaskHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskHistoryPageState();
}

class _TaskHistoryPageState extends State<TaskHistoryPage>
    with AutomaticKeepAliveClientMixin<TaskHistoryPage> {
  late TaskDetailsProvider _provider;

  Future<void> _refresh() async {
    await _provider.loadDetails();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<TaskDetailsProvider>(context);

    super.build(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: _provider.details?.actions == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _provider.details!.actions.isEmpty
              ? Center(
                  child: Text(
                    "Brak elementów",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: _provider.details!.actions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        HistoryActionItem(
                            action: _provider.details!.actions[index]),
                        const DetailsDivider(),
                      ],
                    );
                  },
                ),
    );
  }
}
