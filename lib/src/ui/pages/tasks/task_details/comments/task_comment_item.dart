import 'package:attado_mobile/src/models/data_models/tasks/task_comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCommentItem extends StatefulWidget {
  const TaskCommentItem({
    super.key,
    required this.comment,
  });

  final TaskComment comment;

  @override
  createState() => _TaskCommentItemState();
}

class _TaskCommentItemState extends State<TaskCommentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.comment.firstName} ${widget.comment.surname}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              //const SizedBox(width: 3),
              Text(
                DateFormat('dd.MM.yyyy').format(widget.comment.savedOn),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              widget.comment.commentText,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
