import 'package:attado_mobile/src/models/data_models/tasks/task_priority.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskPrioritiesSearchPage extends StatefulWidget {
  const TaskPrioritiesSearchPage({
    super.key,
    required this.tasksService,
  });

  final TasksService tasksService;

  @override
  State<TaskPrioritiesSearchPage> createState() =>
      _TaskPrioritiesSearchPageState();
}

class _TaskPrioritiesSearchPageState extends State<TaskPrioritiesSearchPage> {
  List<TaskPriority> _filterData(List<TaskPriority> status, String? pattern) {
    if (pattern == null) return status;
    pattern = pattern.toLowerCase();
    return status
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(TaskPriority type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<TaskPriority>(
      autofocus: false,
      fetchData: widget.tasksService.getTasksPriorities(),
      filterData: _filterData,
      listTileBuilder: (TaskPriority priority) => ListTile(
        title: Text(priority.name),
        onTap: () => _onSelected(priority),
      ),
    );
  }
}
