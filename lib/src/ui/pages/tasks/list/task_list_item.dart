import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/ui/common/containers/rounded_text_label.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({
    super.key,
    required this.task,
    this.isMainList = true,
  });
  final Task task;
  final bool isMainList;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  void _onTap() async {
    await context.push("/tasks/details", extra: widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
        child: InkWell(
          onTap: _onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 18,
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 37,
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.taskLight
                          : AppColors.taskDark,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 270,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.task.typeName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('dd.MM.yyyy')
                              .format(widget.task.startDate),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        RoundedTextLabel(
                          text: widget.task.statusName,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.taskConLight
                                  : AppColors.taskConDark,
                          icon: Icons.content_paste_search_outlined,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
