import 'package:attado_mobile/src/models/data_models/tasks/task_member.dart';
import 'package:flutter/material.dart';

class TaskMemberItem extends StatefulWidget {
  const TaskMemberItem({
    super.key,
    required this.member,
  });

  final TaskMember member;

  @override
  State<TaskMemberItem> createState() => _TaskMemberItemState();
}

class _TaskMemberItemState extends State<TaskMemberItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.person_outlined),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  width: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.member.firstName} ${widget.member.surname}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.member.username,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
