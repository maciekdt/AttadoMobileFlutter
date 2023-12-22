import 'package:attado_mobile/src/models/data_models/tasks/task_type.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskTypeSearchPage extends StatefulWidget {
  const TaskTypeSearchPage({
    super.key,
    required this.tasksService,
  });

  final TasksService tasksService;

  @override
  State<TaskTypeSearchPage> createState() => _TaskTypeSearchPageState();
}

class _TaskTypeSearchPageState extends State<TaskTypeSearchPage> {
  List<TaskType> _filterData(List<TaskType> types, String? pattern) {
    if (pattern == null) return types;
    pattern = pattern.toLowerCase();
    return types
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(TaskType type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<TaskType>(
      autofocus: false,
      fetchData: widget.tasksService.getTasksTypes(),
      filterData: _filterData,
      listTileBuilder: (TaskType type) => ListTile(
        leading: const Icon(Icons.task_outlined),
        title: Text(type.name),
        onTap: () => _onSelected(type),
      ),
    );
  }
}
