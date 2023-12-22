import 'dart:convert';
import 'package:attado_mobile/src/models/data_models/common/history_action.dart';
import 'package:attado_mobile/src/models/data_models/common/list_with_length.dart';
import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder_status.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder_type.dart';
import 'package:attado_mobile/src/models/data_models/folders/folders_search_options.dart';
import 'package:attado_mobile/src/services/api_service.dart';
import 'package:attado_mobile/src/services/interfaces/my_filters_service.dart';
import 'package:attado_mobile/src/services/interfaces/system_filters_service.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoldersService implements MyFiltersService, SystemFiltersService {
  FoldersService(this._api);
  final ApiService _api;

  Future<ListWithLength<Folder>> getFolders(
      int page, FoldersSearchOptions options, String? filter, String? queryName,
      {int pageSize = 10}) async {
    if (queryName != null) {
      options = options.clone();
      options.name = queryName;
      if (filter != null) {
        Map<String, dynamic> map = json.decode(filter);
        map["name"] = queryName;
        filter = jsonEncode(map);
      }
    }
    Response response = await _api.client.post(
      Uri.parse(
          '${_api.getBaseUrl()}/api/Folder/search${_api.getPagingParameters(page, pageSize)}'),
      headers: _api.getHeaders(),
      body: filter ?? jsonEncode(options),
    );
    return ListWithLength<Folder>.fromJson(
        json.decode(response.body), (dynamic json) => Folder.fromJson(json));
  }

  Future<Folder> getFolder(int folderId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Folder/$folderId'),
      headers: _api.getHeaders(),
    );
    return Folder.fromJson(json.decode(response.body));
  }

  Future<List<FolderType>> getFoldersTypes() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Dictionary/folder/types'),
      headers: _api.getHeaders(),
    );
    return List<FolderType>.from(
      (json.decode(response.body)).map(
        (model) => FolderType.fromJson(model),
      ),
    );
  }

  Future<List<FolderStatus>> getFoldersStatesForType(int folderTypeId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse(
          '${_api.getBaseUrl()}/api/Dictionary/folder/$folderTypeId/states'),
      headers: _api.getHeaders(),
    );
    return List<FolderStatus>.from(
      (json.decode(response.body)).map(
        (model) => FolderStatus.fromJson(model),
      ),
    );
  }

  @override
  Future<List<MyFilter>> getMyFilters() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Filter/folderGrid'),
      headers: _api.getHeaders(),
    );
    return List<MyFilter>.from(
      (json.decode(response.body)).map(
        (model) => MyFilter.fromJson(model),
      ),
    );
  }

  @override
  List<SystemFilter> getSystemFilters() {
    return _systemFilters;
  }

  Future<List<Folder>> getRelFoldersForDocument(int documentId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/folders/document/$documentId'),
      headers: _api.getHeaders(),
    );
    return List<Folder>.from(
      (json.decode(response.body)).map(
        (model) => Folder.fromJson(model),
      ),
    );
  }

  Future<List<Folder>> getRelFoldersForFolder(int folderId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/folders/folder/$folderId'),
      headers: _api.getHeaders(),
    );
    return List<Folder>.from(
      (json.decode(response.body)).map(
        (model) => Folder.fromJson(model),
      ),
    );
  }

  Future<List<Folder>> getRelFoldersForContact(int contactId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/folders/contact/$contactId'),
      headers: _api.getHeaders(),
    );
    return List<Folder>.from(
      (json.decode(response.body)).map(
        (model) => Folder.fromJson(model),
      ),
    );
  }

  Future<List<HistoryAction>> getFolderHistory(int folderId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Folder/$folderId/actions'),
      headers: _api.getHeaders(),
    );
    return List<HistoryAction>.from(
      (json.decode(response.body)).map(
        (model) => HistoryAction.fromJson(model),
      ),
    );
  }

  static final List<SystemFilter> _systemFilters = [
    SystemFilter(name: "Wszystko", value: "ALL"),
    SystemFilter(name: "Utworzyłem", value: "CREATOR_ME"),
  ];
}
