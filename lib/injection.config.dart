// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'src/repos/auth_repo.dart' as _i4;
import 'src/services/api_service.dart' as _i5;
import 'src/services/auth_service.dart' as _i3;
import 'src/services/contacts_service.dart' as _i6;
import 'src/services/documents_service.dart' as _i7;
import 'src/services/folders_service.dart' as _i8;
import 'src/services/notifications_service.dart' as _i9;
import 'src/services/tasks_service.dart' as _i10;
import 'src/services/users_service.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthService>(() => _i3.AuthService());
    gh.singleton<_i4.AuthRepo>(_i4.AuthRepo(gh<_i3.AuthService>()));
    gh.factory<_i5.ApiService>(() => _i5.ApiService(gh<_i4.AuthRepo>()));
    gh.factory<_i6.ContactsService>(
        () => _i6.ContactsService(gh<_i5.ApiService>()));
    gh.factory<_i7.DocumentsService>(
        () => _i7.DocumentsService(gh<_i5.ApiService>()));
    gh.factory<_i8.FoldersService>(
        () => _i8.FoldersService(gh<_i5.ApiService>()));
    gh.factory<_i9.NotyficationsService>(() => _i9.NotyficationsService(
          gh<_i5.ApiService>(),
          gh<_i4.AuthRepo>(),
          gh<_i7.DocumentsService>(),
        ));
    gh.factory<_i10.TasksService>(
        () => _i10.TasksService(gh<_i5.ApiService>()));
    gh.factory<_i11.UsersService>(
        () => _i11.UsersService(gh<_i5.ApiService>()));
    return this;
  }
}
