import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder_status.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder_type.dart';
import 'package:attado_mobile/src/models/data_models/folders/folders_search_options.dart';
import 'package:attado_mobile/src/models/data_models/users/user.dart';
import 'package:attado_mobile/src/models/data_models/users/user_details.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/services/users_service.dart';
import 'package:flutter/material.dart';

class FoldersOptionsProvider extends ChangeNotifier {
  UsersService usersService = getIt<UsersService>();
  AuthRepo authRepo = getIt<AuthRepo>();
  FoldersService foldersService = getIt<FoldersService>();

  FoldersSearchOptions _options = FoldersSearchOptions();
  FoldersSearchOptions get options => _options;

  void setName(String? name) {
    resetCustomFilters();
    _options.name = name;
    notifyListeners();
  }

  void setFolderNumber(String? number) {
    resetCustomFilters();
    _options.folderNumber = number;
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

  User? _createUser;
  User? get createUser => _createUser;
  set createUser(User? user) {
    resetCustomFilters();
    _options.createUserId = user?.id;
    _createUser = user;
    notifyListeners();
  }

  User? _responsibleUser;
  User? get responsibleUser => _responsibleUser;
  set responsibleUser(User? user) {
    resetCustomFilters();
    _options.responsibleUserId = user?.id;
    _responsibleUser = user;
    notifyListeners();
  }

  FolderType? _folderType;
  FolderType? get folderType => _folderType;
  set folderType(FolderType? type) {
    resetCustomFilters();
    _options.typeId = type?.id;
    _folderType = type;
    notifyListeners();
  }

  FolderStatus? _folderStatus;
  FolderStatus? get folderStatus => _folderStatus;
  set folderStatus(FolderStatus? state) {
    resetCustomFilters();
    _options.statusId = state?.id;
    _folderStatus = state;
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
    } else if (filter != null && filter.value == "ALL") {
      _options = FoldersSearchOptions();
      notifyListeners();
    }
  }

  Future<void> setStartFilter() async {
    List<MyFilter> filters = await foldersService.getMyFilters();
    try {
      myFilter = filters.firstWhere(
        (filter) => filter.startingFilter,
      );
    } on StateError catch (_) {}
    notifyListeners();
  }

  void resetAllFilters() {
    _options = FoldersSearchOptions();
    _createUser = null;
    _responsibleUser = null;
    _folderType = null;
    _folderStatus = null;
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
    if (_options.folderNumber != null) filters++;
    if (_options.description != null) filters++;
    if (_options.contactFullName != null) filters++;
    if (_options.createUserId != null) filters++;
    if (_options.responsibleUserId != null) filters++;
    if (_options.typeId != null) filters++;
    if (_options.statusId != null) filters++;
    if (_myFilter != null) filters++;
    if (_systemFilter != null) filters++;
    if (_systemFilter != null && _options.createUserId != null) filters--;
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
