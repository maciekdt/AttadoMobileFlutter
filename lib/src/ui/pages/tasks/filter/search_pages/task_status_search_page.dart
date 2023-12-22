import 'package:attado_mobile/src/models/data_models/tasks/task_status.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskStatusSearchPage extends StatefulWidget {
  const TaskStatusSearchPage({
    super.key,
    required this.tasksService,
  });

  final TasksService tasksService;

  @override
  State<TaskStatusSearchPage> createState() => _TaskStatusSearchPageState();
}

class _TaskStatusSearchPageState extends State<TaskStatusSearchPage> {
  List<TaskStatus> _filterData(List<TaskStatus> status, String? pattern) {
    if (pattern == null) return status;
    pattern = pattern.toLowerCase();
    return status
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(TaskStatus type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<TaskStatus>(
      autofocus: false,
      fetchData: widget.tasksService.getTasksStatuses(),
      filterData: _filterData,
      listTileBuilder: (TaskStatus status) => ListTile(
        leading: const Icon(Icons.content_paste_search_outlined),
        title: Text(status.name),
        onTap: () => _onSelected(status),
      ),
    );
  }
}
