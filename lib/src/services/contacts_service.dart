import 'package:attado_mobile/src/models/data_models/common/history_action.dart';
import 'package:attado_mobile/src/models/data_models/common/list_with_length.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact_type.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contacts_search_options.dart';
import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/services/api_service.dart';
import 'package:attado_mobile/src/services/interfaces/my_filters_service.dart';
import 'package:attado_mobile/src/services/interfaces/system_filters_service.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';

@injectable
class ContactsService implements MyFiltersService, SystemFiltersService {
  ContactsService(this._api);
  final ApiService _api;

  Future<ListWithLength<Contact>> getContacts(int page,
      ContactsSearchOptions options, String? filter, String? queryName,
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
          '${_api.getBaseUrl()}/api/Contact/search${_api.getPagingParameters(page, pageSize)}'),
      headers: _api.getHeaders(),
      body: filter ?? jsonEncode(options),
    );
    return ListWithLength<Contact>.fromJson(
        json.decode(response.body), (dynamic json) => Contact.fromJson(json));
  }

  Future<Contact> getContact(int contactId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Contact/$contactId'),
      headers: _api.getHeaders(),
    );
    return Contact.fromJson(json.decode(response.body));
  }

  Future<List<ContactType>> getContactsTypes() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Dictionary/contact/kinds'),
      headers: _api.getHeaders(),
    );
    return List<ContactType>.from(
      (json.decode(response.body)).map(
        (model) => ContactType.fromJson(model),
      ),
    );
  }

  @override
  Future<List<MyFilter>> getMyFilters() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Filter/contact'),
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

  Future<List<Contact>> getRelContactsForDocument(int documentId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/contacts/document/$documentId'),
      headers: _api.getHeaders(),
    );
    return List<Contact>.from(
      (json.decode(response.body)).map(
        (model) => Contact.fromJson(model),
      ),
    );
  }

  Future<List<Contact>> getRelContactsForFolder(int folderId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/contacts/folder/$folderId'),
      headers: _api.getHeaders(),
    );
    return List<Contact>.from(
      (json.decode(response.body)).map(
        (model) => Contact.fromJson(model),
      ),
    );
  }

  Future<List<Contact>> getRelTasksForFolder(int taskId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/contacts/task/$taskId'),
      headers: _api.getHeaders(),
    );
    return List<Contact>.from(
      (json.decode(response.body)).map(
        (model) => Contact.fromJson(model),
      ),
    );
  }

  Future<List<Contact>> getRelContactsForContact(int contactId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/contacts/contact/$contactId'),
      headers: _api.getHeaders(),
    );
    return List<Contact>.from(
      (json.decode(response.body)).map(
        (model) => Contact.fromJson(model),
      ),
    );
  }

  Future<List<HistoryAction>> getContactHistory(int contactId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Contact/$contactId/actions'),
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
