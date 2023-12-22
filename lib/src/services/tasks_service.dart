import 'dart:convert';
import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_details.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_priority.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_status.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_type.dart';
import 'package:attado_mobile/src/models/data_models/tasks/tasks_search_options.dart';
import 'package:attado_mobile/src/models/data_models/common/list_with_length.dart';
import 'package:attado_mobile/src/services/api_service.dart';
import 'package:attado_mobile/src/services/interfaces/my_filters_service.dart';
import 'package:attado_mobile/src/services/interfaces/system_filters_service.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@injectable
class TasksService implements MyFiltersService, SystemFiltersService {
  TasksService(this._api);
  final ApiService _api;

  Future<ListWithLength<Task>> getTasks(
      int page, TasksSearchOptions options, String? filter, String? queryName,
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
          '${_api.getBaseUrl()}/api/Task/search${_api.getPagingParameters(page, pageSize)}'),
      headers: _api.getHeaders(),
      body: filter ?? jsonEncode(options),
    );
    return ListWithLength<Task>.fromJson(
        json.decode(response.body), (dynamic json) => Task.fromJson(json));
  }

  Future<Task> getTask(int taskId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Task/$taskId'),
      headers: _api.getHeaders(),
    );
    return Task.fromJson(json.decode(response.body));
  }

  Future<List<TaskType>> getTasksTypes() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Dictionary/task/types'),
      headers: _api.getHeaders(),
    );
    return List<TaskType>.from(
      (json.decode(response.body)).map(
        (model) => TaskType.fromJson(model),
      ),
    );
  }

  Future<List<TaskStatus>> getTasksStatuses() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Dictionary/task/statuses'),
      headers: _api.getHeaders(),
    );
    return List<TaskStatus>.from(
      (json.decode(response.body)).map(
        (model) => TaskStatus.fromJson(model),
      ),
    );
  }

  Future<List<TaskPriority>> getTasksPriorities() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Dictionary/task/priorities'),
      headers: _api.getHeaders(),
    );
    return List<TaskPriority>.from(
      (json.decode(response.body)).map(
        (model) => TaskPriority.fromJson(model),
      ),
    );
  }

  @override
  Future<List<MyFilter>> getMyFilters() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Filter/task'),
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

  Future<List<Task>> getRelTasksForDocument(int documentId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/tasks/document/$documentId'),
      headers: _api.getHeaders(),
    );
    return List<Task>.from(
      (json.decode(response.body)).map(
        (model) => Task.fromJson(model),
      ),
    );
  }

  Future<List<Task>> getRelTasksForFolder(int folderId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/tasks/folder/$folderId'),
      headers: _api.getHeaders(),
    );
    return List<Task>.from(
      (json.decode(response.body)).map(
        (model) => Task.fromJson(model),
      ),
    );
  }

  Future<List<Task>> getRelTasksForContact(int contactId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/tasks/contact/$contactId'),
      headers: _api.getHeaders(),
    );
    return List<Task>.from(
      (json.decode(response.body)).map(
        (model) => Task.fromJson(model),
      ),
    );
  }

  Future<TaskDetails> getTaskDetails(int taskId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Task/$taskId'),
      headers: _api.getHeaders(),
    );
    return TaskDetails.fromJson(jsonDecode(response.body));
  }

  static final List<SystemFilter> _systemFilters = [
    SystemFilter(name: "Wszystko", value: "ALL"),
    SystemFilter(name: "Utworzyłem", value: "CREATOR_ME"),
  ];
}
