import 'dart:async';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/common/list_items/related_object_item.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/task_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskRelatedObjectsPage extends StatefulWidget {
  const TaskRelatedObjectsPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskRelatedObjectsPageState();
}

class _TaskRelatedObjectsPageState extends State<TaskRelatedObjectsPage>
    with AutomaticKeepAliveClientMixin<TaskRelatedObjectsPage> {
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
      child: _provider.details?.relatedItems == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _provider.details!.relatedItems.isEmpty
              ? Center(
                  child: Text(
                    "Brak elementów",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: _provider.details!.relatedItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        RelatedObjectItem(
                            item: _provider.details!.relatedItems[index]),
                        const DetailsDivider(),
                      ],
                    );
                  },
                ),
    );
  }
}
