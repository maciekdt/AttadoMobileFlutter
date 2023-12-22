import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/ui/pages/tasks/list/task_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RelTasksPage extends StatefulWidget {
  const RelTasksPage({
    super.key,
    required this.tasks,
    required this.title,
  });

  final List<Task> tasks;
  final String title;

  @override
  State<StatefulWidget> createState() => _RelTasksPageState();
}

class _RelTasksPageState extends State<RelTasksPage> {
  List<Task> _filteredTasks = [];
  bool _search = false;

  @override
  void initState() {
    _filteredTasks = widget.tasks;
    super.initState();
  }

  void _swipeSearch() {
    setState(() {
      _filteredTasks = widget.tasks;
      _search = !_search;
    });
  }

  void _filterList(String? pattern) {
    pattern = pattern?.toLowerCase();
    setState(() {
      _filteredTasks = widget.tasks
          .where((folder) => folder.name.toLowerCase().contains(pattern!))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_search
          ? AppBar(
              leadingWidth: 40,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 3, top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 14.5),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Powiązane zadania",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: _swipeSearch,
                  icon: const Icon(Icons.search),
                ),
              ],
            )
          : PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 3.0,
                  right: 10,
                  left: 10,
                  bottom: 5,
                ),
                child: TextFormField(
                  onChanged: _filterList,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 28,
                      ),
                      onPressed: _swipeSearch,
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Szukaj...',
                    focusedBorder: null,
                  ),
                ),
              ),
            ),
      body: _filteredTasks.isEmpty
          ? Center(
              child: Text(
                "Brak elementów",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          : ListView.builder(
              itemCount: _filteredTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskListItem(
                  task: _filteredTasks[index],
                  isMainList: false,
                );
              },
            ),
    );
  }
}
