import 'dart:async';
import 'dart:io';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:attado_mobile/src/ui/common/appbars/search_app_bar.dart';
import 'package:attado_mobile/src/ui/common/badges/counter_badge.dart';
import 'package:attado_mobile/src/ui/common/exceptions/client_exception_footer.dart';
import 'package:attado_mobile/src/ui/common/exceptions/client_exception_page.dart';
import 'package:attado_mobile/src/ui/common/exceptions/offline_exception_footer.dart';
import 'package:attado_mobile/src/ui/common/exceptions/offline_exception_page.dart';
import 'package:attado_mobile/src/ui/common/icon_buttons/filter_icon_button.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/pages/tasks/list/task_list_item.dart';
import 'package:attado_mobile/src/ui/pages/tasks/providers/tasks_options_provider.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({
    super.key,
    required this.tasksService,
    required this.authRepo,
  });

  final TasksService tasksService;
  final AuthRepo authRepo;

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  final _numberOfPostsPerRequest = 10;
  final PagingController<int, Task> _pagingController =
      PagingController(firstPageKey: 1);
  late TasksOptionsProvider _optionsProvider;
  late AppProvider _appProvider;
  int? _itemsCount;
  bool _search = false;
  String? _searchQuery;
  StreamSubscription<void>? _lastSearchAction;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (_appProvider.tasksListFirstRun) {
        await _optionsProvider.setStartFilter();
        _appProvider.tasksListFirstRun = false;
      }
      final foldersList = await widget.tasksService.getTasks(
        pageKey,
        _optionsProvider.options,
        _optionsProvider.myFilter?.filterValue,
        _searchQuery,
      );
      setState(() {
        _itemsCount = foldersList.totalElements;
      });
      final isLastPage = foldersList.items.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(foldersList.items);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(foldersList.items, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  Future<void> _goToFilter() async {
    await context.push("/tasks/filter");
    _pagingController.refresh();
  }

  Future<void> _onTextChanged(String? text) async {
    if (text != null) {
      setState(() {
        _searchQuery = text;
      });
    }
    if (_lastSearchAction != null) {
      _lastSearchAction!.cancel();
    }
    _lastSearchAction =
        Future.delayed(const Duration(seconds: 1)).asStream().listen((_) {
      _pagingController.refresh();
    });
  }

  void _cancelSearch() {
    setState(() {
      _searchQuery = null;
      _search = false;
    });
    _pagingController.refresh();
  }

  void _startSearch() {
    setState(() {
      _search = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _optionsProvider = Provider.of<TasksOptionsProvider>(context);
    _appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.taskBackgroundLight
          : AppColors.taskBackgroundDark,
      appBar: !_search
          ? AppBar(
              leadingWidth: 200,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 2),
                  const Image(
                    image: AssetImage('assets/icon.png'),
                    width: 40,
                  ),
                  Text("Zadania",
                      style: Theme.of(context).appBarTheme.titleTextStyle),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 12),
                    child: CounterBadge(
                      value: _itemsCount,
                      maxValue: null,
                      background:
                          Theme.of(context).brightness == Brightness.light
                              ? AppColors.taskConLight
                              : AppColors.taskConDark,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: _startSearch,
                  icon: const Icon(Icons.search),
                ),
                FilterIconButton(
                  filtersCount: _optionsProvider.filtersCount,
                  onTap: _goToFilter,
                ),
              ],
            )
          : PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height),
              child: SearchAppBar(
                cancelSearch: _cancelSearch,
                onTextChanged: _onTextChanged,
              ),
            ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() {
          _pagingController.refresh();
        }),
        child: PagedListView<int, Task>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Task>(
            itemBuilder: (context, item, index) {
              return TaskListItem(task: item);
            },
            noItemsFoundIndicatorBuilder: (context) {
              return Center(
                child: Text(
                  "Brak zadań",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (_) {
              if (_pagingController.error is SocketException) {
                return OfflineExceptionPage(
                  onRefresh: () => _pagingController.refresh(),
                );
              } else {
                return ClientExceptionPage(
                  onRefresh: () => _pagingController.refresh(),
                );
              }
            },
            newPageErrorIndicatorBuilder: (_) {
              if (_pagingController.error is SocketException) {
                return OfflineExceptionFooter(
                  onRefresh: () => _pagingController.retryLastFailedRequest(),
                );
              } else {
                return ClientExceptionFooter(
                  onRefresh: () => _pagingController.retryLastFailedRequest(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
