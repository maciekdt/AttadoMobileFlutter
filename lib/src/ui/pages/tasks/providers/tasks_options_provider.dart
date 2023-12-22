import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_priority.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_status.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_type.dart';
import 'package:attado_mobile/src/models/data_models/tasks/tasks_search_options.dart';
import 'package:attado_mobile/src/models/data_models/users/user_details.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:attado_mobile/src/services/users_service.dart';
import 'package:flutter/material.dart';

class TasksOptionsProvider extends ChangeNotifier {
  UsersService usersService = getIt<UsersService>();
  AuthRepo authRepo = getIt<AuthRepo>();
  TasksService tasksService = getIt<TasksService>();

  TasksSearchOptions _options = TasksSearchOptions();
  TasksSearchOptions get options => _options;

  void setName(String? name) {
    resetCustomFilters();
    _options.name = name;
    notifyListeners();
  }

  void setDescription(String? description) {
    resetCustomFilters();
    _options.description = description;
    notifyListeners();
  }

  void setContactFullName(String? name) {
    resetCustomFilters();
    _options.contactFullName = name;
    notifyListeners();
  }

  TaskType? _taskType;
  TaskType? get taskType => _taskType;
  set taskType(TaskType? type) {
    resetCustomFilters();
    _options.typeId = type?.id;
    _taskType = type;
    notifyListeners();
  }

  TaskStatus? _taskStatus;
  TaskStatus? get taskStatus => _taskStatus;
  set taskStatus(TaskStatus? state) {
    resetCustomFilters();
    _options.statusId = state?.id;
    _taskStatus = state;
    notifyListeners();
  }

  TaskPriority? _taskPriority;
  TaskPriority? get taskPriority => _taskPriority;
  set taskPriority(TaskPriority? priority) {
    resetCustomFilters();
    _options.priorityId = priority?.id;
    _taskPriority = priority;
    notifyListeners();
  }

  MyFilter? _myFilter;
  MyFilter? get myFilter => _myFilter;
  set myFilter(MyFilter? filter) {
    resetAllFilters();
    _myFilter = filter;
    notifyListeners();
  }

  SystemFilter? _systemFilter;
  SystemFilter? get systemFilter => _systemFilter;
  set systemFilter(SystemFilter? filter) {
    resetAllFilters();
    _systemFilter = filter;
    if (filter != null && filter.value == "CREATOR_ME") {
      usersService.getUser(authRepo.authUser!.username).then(
        (UserDetails user) {
          _options.createUserId = user.id;
          notifyListeners();
        },
      );
    } else {
      _options.filter = filter?.value;
      notifyListeners();
    }
  }

  Future<void> setStartFilter() async {
    List<MyFilter> filters = await tasksService.getMyFilters();
    try {
      myFilter = filters.firstWhere(
        (filter) => filter.startingFilter,
      );
    } on StateError catch (_) {}
    notifyListeners();
  }

  void resetAllFilters() {
    _options = TasksSearchOptions();
    _taskType = null;
    _taskStatus = null;
    _taskPriority = null;
    _myFilter = null;
    _systemFilter = null;
    notifyListeners();
  }

  void resetCustomFilters() {
    _myFilter = null;
    _systemFilter = null;
    notifyListeners();
  }

  int get filtersCount {
    int filters = 0;
    if (_options.name != null) filters++;
    if (_options.description != null) filters++;
    if (_options.contactFullName != null) filters++;
    if (_options.typeId != null) filters++;
    if (_options.statusId != null) filters++;
    if (_options.priorityId != null) filters++;
    if (_myFilter != null) filters++;
    if (_systemFilter != null) filters++;
    return filters;
  }

  int get customFiltersCount {
    int filters = 0;
    if (_myFilter != null) filters++;
    if (_systemFilter != null) filters++;
    return filters;
  }

  int get standardFiltersCount => filtersCount - customFiltersCount;
}
