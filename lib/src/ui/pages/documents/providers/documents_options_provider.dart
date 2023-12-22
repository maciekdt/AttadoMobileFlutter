import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/documents/document_state.dart';
import 'package:attado_mobile/src/models/data_models/documents/document_type.dart';
import 'package:attado_mobile/src/models/data_models/documents/documents_search_options.dart';
import 'package:attado_mobile/src/models/data_models/documents/file_type.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/models/data_models/users/user.dart';
import 'package:attado_mobile/src/models/data_models/users/user_details.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/services/users_service.dart';
import 'package:flutter/material.dart';

class DocumentsOptionsProvider extends ChangeNotifier {
  UsersService usersService = getIt<UsersService>();
  AuthRepo authRepo = getIt<AuthRepo>();
  DocumentsService documentsService = getIt<DocumentsService>();

  DocumentsSearchOptions _options = DocumentsSearchOptions();
  DocumentsSearchOptions get options => _options;

  User? _user;
  User? get user => _user;
  set user(User? user) {
    resetCustomFilters();
    _options.createUserId = user?.id;
    _user = user;
    notifyListeners();
  }

  DocumentType? _documentType;
  DocumentType? get documentType => _documentType;
  set documentType(DocumentType? type) {
    resetCustomFilters();
    _options.typeId = type?.id;
    _documentType = type;
    notifyListeners();
  }

  FileType? _fileType;
  FileType? get fileType => _fileType;
  set fileType(FileType? type) {
    resetCustomFilters();
    _options.fileKind = type?.value;
    _fileType = type;
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

  DocumentState? _state;
  DocumentState? get state => _state;
  set state(DocumentState? state) {
    resetCustomFilters();
    _options.workFlowStateId = state?.id;
    _state = state;
    notifyListeners();
  }

  int get standardFiltersCount => filtersCount - customFiltersCount;

  Future<void> setStartFilter() async {
    List<MyFilter> filters = await documentsService.getMyFilters();
    try {
      myFilter = filters.firstWhere(
        (filter) => filter.startingFilter,
      );
    } on StateError catch (_) {}
    notifyListeners();
  }

  void setName(String? name) {
    resetCustomFilters();
    _options.name = name;
    notifyListeners();
  }

  void setDocumentNumber(String? number) {
    resetCustomFilters();
    _options.documentNumber = number;
    notifyListeners();
  }

  void setDescription(String? description) {
    resetCustomFilters();
    _options.description = description;
    notifyListeners();
  }

  void setOnlyLast(bool onlyLast) {
    resetCustomFilters();
    _options.onlyLast = onlyLast;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void resetAllFilters() {
    _options = DocumentsSearchOptions();
    _fileType = null;
    _documentType = null;
    _user = null;
    _myFilter = null;
    _state = null;
    _systemFilter = null;
    notifyListeners();
  }

  void resetCustomFilters() {
    _myFilter = null;
    _systemFilter = null;
    _options.filter = null;
    _options.createUserId = null;
    notifyListeners();
  }

  int get filtersCount {
    int filters = 0;
    if (_options.name != null) filters++;
    if (_options.documentNumber != null) filters++;
    if (_options.description != null) filters++;
    if (_options.onlyLast) filters++;
    if (_options.createUserId != null) filters++;
    if (_options.typeId != null) filters++;
    if (_options.fileKind != null) filters++;
    if (_options.workFlowStateId != null) filters++;
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

  String getUserText(User user) {
    return (user.surname.isNotEmpty || user.firstName.isNotEmpty)
        ? '${user.firstName} ${user.surname}'
        : user.username;
  }
}
