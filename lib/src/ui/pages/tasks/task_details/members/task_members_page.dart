import 'dart:async';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/members/task_member_item.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/task_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskMembersPage extends StatefulWidget {
  const TaskMembersPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskMembersPageState();
}

class _TaskMembersPageState extends State<TaskMembersPage>
    with AutomaticKeepAliveClientMixin<TaskMembersPage> {
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
      child: _provider.details?.members == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _provider.details!.members.isEmpty
              ? Center(
                  child: Text(
                    "Brak elementów",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: _provider.details!.members.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        TaskMemberItem(
                            member: _provider.details!.members[index]),
                        const DetailsDivider(),
                      ],
                    );
                  },
                ),
    );
  }
}
