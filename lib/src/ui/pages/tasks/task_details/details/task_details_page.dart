import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/ui/common/containers/text_with_label.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextWithLabel(
            label: "Nazwa",
            text: widget.task.name,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Rodzaj",
            text: widget.task.typeName,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Status",
            text: widget.task.statusName,
          ),
          const DetailsDivider(),
          widget.task.contactFullName != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Kontrahent",
                      text: widget.task.contactFullName!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          const DetailsDivider(),
          widget.task.priorityName != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Priorytet",
                      text: widget.task.priorityName!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          TextWithLabel(
            label: "Data rozpoczęcia",
            text: DateFormat('dd.MM.yyyy').format(widget.task.startDate),
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Data zakończenia",
            text: DateFormat('dd.MM.yyyy').format(widget.task.endDate),
          ),
          const DetailsDivider(),
          widget.task.description != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Opis działania",
                      text: widget.task.description!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.task.location != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Lokalizacja",
                      text: widget.task.location!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          TextWithLabel(
            label: "Opracował",
            text:
                '${widget.task.createUserFirstName} ${widget.task.createUserSurname}',
            subText:
                DateFormat('dd.MM.yyyy HH:mm').format(widget.task.createDate),
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Zmodyfikował",
            text:
                '${widget.task.updateUserFirstName} ${widget.task.updateUserSurname}',
            subText:
                DateFormat('dd.MM.yyyy HH:mm').format(widget.task.updateDate),
          ),
          const DetailsDivider(),
        ],
      ),
    );
  }
}
