import 'package:attado_mobile/src/models/data_models/common/history_action.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryActionItem extends StatelessWidget {
  const HistoryActionItem({
    super.key,
    required this.action,
  });

  final HistoryAction action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(action.savedOn),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 15),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(top: 1.3),
                child: Text(
                    action.firstName == null || action.surname == null
                        ? action.username
                        : '${action.firstName!} ${action.surname!}',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 15),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(top: 1.3),
                child: SizedBox(
                  width: 300,
                  child: Text(action.actionName,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
