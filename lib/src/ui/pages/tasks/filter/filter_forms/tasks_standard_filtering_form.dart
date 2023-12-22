import 'package:attado_mobile/src/models/data_models/tasks/task_priority.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_status.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_type.dart';
import 'package:attado_mobile/src/ui/common/containers/select_field_container.dart';
import 'package:attado_mobile/src/ui/pages/tasks/providers/tasks_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TasksStandardFilteringForm extends StatefulWidget {
  const TasksStandardFilteringForm({super.key});

  @override
  State<StatefulWidget> createState() => _TasksStandardFilteringFormState();
}

class _TasksStandardFilteringFormState
    extends State<TasksStandardFilteringForm> {
  late TasksOptionsProvider _optionsProvider;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerContactName = TextEditingController();

  @override
  void initState() {
    final tempOptionsProvider =
        Provider.of<TasksOptionsProvider>(context, listen: false);
    if (tempOptionsProvider.options.name != null) {
      _controllerName.text = tempOptionsProvider.options.name!;
    }
    if (tempOptionsProvider.options.description != null) {
      _controllerDescription.text = tempOptionsProvider.options.description!;
    }
    if (tempOptionsProvider.options.contactFullName != null) {
      _controllerContactName.text =
          tempOptionsProvider.options.contactFullName!;
    }

    super.initState();
  }

  void _onNameChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setName(text);
    }
  }

  void _onNameCancel() {
    _optionsProvider.setName(null);
    _controllerName.clear();
  }

  void _onDescriptionChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setDescription(text);
    }
  }

  void _onDescriptionCancel() {
    _optionsProvider.setDescription(null);
    _controllerDescription.clear();
  }

  void _onContactNameChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setContactFullName(text);
    }
  }

  void _onContactNameCancel() {
    _optionsProvider.setContactFullName(null);
    _controllerContactName.clear();
  }

  void _unselectType() {
    _optionsProvider.taskType = null;
  }

  void _selectType() async {
    var result = await context.push("/tasks/filter/type");
    if (result != null) {
      _optionsProvider.taskType = result as TaskType;
    }
  }

  void _selectStatus() async {
    var result = await context.push("/tasks/filter/status");
    if (result != null) {
      _optionsProvider.taskStatus = result as TaskStatus;
    }
  }

  void _unselectStatus() {
    _optionsProvider.taskStatus = null;
  }

  void _selectPriority() async {
    var result = await context.push("/tasks/filter/priority");
    if (result != null) {
      _optionsProvider.taskPriority = result as TaskPriority;
    }
  }

  void _unselectPriority() {
    _optionsProvider.taskPriority = null;
  }

  @override
  Widget build(BuildContext context) {
    _optionsProvider = Provider.of<TasksOptionsProvider>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerName,
              keyboardType: TextInputType.name,
              onChanged: _onNameChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.badge_outlined),
                border: const OutlineInputBorder(),
                hintText: "Nazwa",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.name != null
                    ? IconButton(
                        onPressed: _onNameCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectType,
              prefixIcon: Icons.task_outlined,
              text: _optionsProvider.taskType == null
                  ? Text(
                      "Typ",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.taskType!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.taskType == null
                  ? null
                  : IconButton(
                      onPressed: _unselectType,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectStatus,
              prefixIcon: Icons.content_paste_search_outlined,
              text: _optionsProvider.taskStatus == null
                  ? Text(
                      "Status",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.taskStatus!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.taskStatus == null
                  ? null
                  : IconButton(
                      onPressed: _unselectStatus,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectPriority,
              prefixIcon: Icons.priority_high,
              text: _optionsProvider.taskPriority == null
                  ? Text(
                      "Priorytet",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.taskPriority!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.taskPriority == null
                  ? null
                  : IconButton(
                      onPressed: _unselectPriority,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerDescription,
              keyboardType: TextInputType.name,
              onChanged: _onDescriptionChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.info_outline),
                border: const OutlineInputBorder(),
                hintText: "Info",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.description != null
                    ? IconButton(
                        onPressed: _onDescriptionCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerContactName,
              keyboardType: TextInputType.name,
              onChanged: _onContactNameChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outlined),
                border: const OutlineInputBorder(),
                hintText: "Kontrahent",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.contactFullName != null
                    ? IconButton(
                        onPressed: _onContactNameCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
