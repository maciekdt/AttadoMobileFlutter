import 'dart:async';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/comments/task_comment_item.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/task_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskCommentPage extends StatefulWidget {
  const TaskCommentPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskCommentPageState();
}

class _TaskCommentPageState extends State<TaskCommentPage>
    with AutomaticKeepAliveClientMixin<TaskCommentPage> {
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
      child: _provider.details?.comments == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _provider.details!.comments.isEmpty
              ? Center(
                  child: Text(
                    "Brak elementów",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: _provider.details!.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        TaskCommentItem(
                            comment: _provider.details!.comments[index]),
                        const DetailsDivider(),
                      ],
                    );
                  },
                ),
    );
  }
}
