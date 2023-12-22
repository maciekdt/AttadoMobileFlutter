import 'package:attado_mobile/src/models/data_models/common/item_type.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/ui/common/tabs/tab_with_counter.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/comments/task_comments_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/details/task_details_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/history/task_history_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/members/task_members_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/related/task_related_objects_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/task_details_provider.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  State<StatefulWidget> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskDetailsProvider(task: widget.task),
      child: Consumer<TaskDetailsProvider>(
        builder: (context, provider, child) => DefaultTabController(
          length: 5,
          child: Scaffold(
              appBar: AppBar(
                leadingWidth: 40,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 3, top: 4),
                  child: Text(widget.task.name),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  indicatorColor:
                      Theme.of(context).brightness == Brightness.light
                          ? AppColors.taskLight
                          : AppColors.taskDark,
                  labelColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.taskLight
                      : AppColors.taskDark,
                  tabs: [
                    const Tab(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.task_alt),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TabWithCounter(
                        label: "Uczestnicy",
                        value: provider.details?.members.length,
                        itemType: ItemType.task,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TabWithCounter(
                        label: "Komentarze",
                        value: provider.details?.comments.length,
                        itemType: ItemType.task,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TabWithCounter(
                        label: "Powiązane",
                        value: provider.details?.relatedItems.length,
                        itemType: ItemType.task,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TabWithCounter(
                        label: "Historia",
                        value: provider.details?.actions.length,
                        itemType: ItemType.task,
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  TaskDetailsPage(task: widget.task),
                  const TaskMembersPage(),
                  const TaskCommentPage(),
                  const TaskRelatedObjectsPage(),
                  const TaskHistoryPage(),
                ],
              )),
        ),
      ),
    );
  }
}
