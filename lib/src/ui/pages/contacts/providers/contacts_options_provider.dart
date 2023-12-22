import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact_type.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contacts_search_options.dart';
import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/models/data_models/users/user.dart';
import 'package:attado_mobile/src/models/data_models/users/user_details.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/contacts_service.dart';
import 'package:attado_mobile/src/services/users_service.dart';
import 'package:flutter/material.dart';

class ContactsOptionsProvider extends ChangeNotifier {
  UsersService usersService = getIt<UsersService>();
  AuthRepo authRepo = getIt<AuthRepo>();
  ContactsService contactsService = getIt<ContactsService>();

  ContactsSearchOptions _options = ContactsSearchOptions();
  ContactsSearchOptions get options => _options;

  void setName(String? name) {
    resetCustomFilters();
    _options.name = name;
    notifyListeners();
  }

  void setEmail(String? email) {
    resetCustomFilters();
    _options.email = email;
    notifyListeners();
  }

  void setId(String? id) {
    resetCustomFilters();
    _options.contactId = id;
    notifyListeners();
  }

  void setAddress(String? address) {
    resetCustomFilters();
    _options.address = address;
    notifyListeners();
  }

  void setPhone(String? phone) {
    resetCustomFilters();
    _options.phone = phone;
    notifyListeners();
  }

  void setDescription(String? phone) {
    resetCustomFilters();
    _options.description = phone;
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

  ContactType? _contactType;
  ContactType? get contactType => _contactType;
  set contactType(ContactType? type) {
    resetCustomFilters();
    _options.typeId = type?.id;
    _contactType = type;
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
      _options = ContactsSearchOptions();
      notifyListeners();
    }
  }

  Future<void> setStartFilter() async {
    List<MyFilter> filters = await contactsService.getMyFilters();
    try {
      myFilter = filters.firstWhere(
        (filter) => filter.startingFilter,
      );
    } on StateError catch (_) {}
    notifyListeners();
  }

  void resetAllFilters() {
    _options = ContactsSearchOptions();
    _createUser = null;
    _responsibleUser = null;
    _contactType = null;
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
    if (_options.email != null) filters++;
    if (_options.contactId != null) filters++;
    if (_options.address != null) filters++;
    if (_options.phone != null) filters++;
    if (_options.description != null) filters++;
    if (_options.createUserId != null) filters++;
    if (_options.responsibleUserId != null) filters++;
    if (_options.typeId != null) filters++;
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
