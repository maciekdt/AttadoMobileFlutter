import 'dart:io';
import 'package:attado_mobile/src/models/data_models/common/global_search_query.dart';
import 'package:attado_mobile/src/models/data_models/common/history_action.dart';
import 'package:attado_mobile/src/models/data_models/common/list_with_length.dart';
import 'package:attado_mobile/src/models/data_models/common/related_item.dart';
import 'package:attado_mobile/src/models/data_models/documents/document_attachment_file.dart';
import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/models/data_models/documents/document_type.dart';
import 'package:attado_mobile/src/models/data_models/documents/documents_search_options.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/services/interfaces/my_filters_service.dart';
import 'package:attado_mobile/src/services/interfaces/system_filters_service.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import '../models/data_models/documents/document_state.dart';
import '../models/data_models/documents/file_type.dart';
import 'api_service.dart';
import 'dart:convert';

@injectable
class DocumentsService implements MyFiltersService, SystemFiltersService {
  DocumentsService(this._api);
  final ApiService _api;

  Future<ListWithLength<Document>> getDocuments(int page,
      DocumentsSearchOptions options, String? filter, String? queryName,
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
          '${_api.getBaseUrl()}/api/Document/search${_api.getPagingParameters(page, pageSize)}'),
      headers: _api.getHeaders(),
      body: filter ?? jsonEncode(options),
    );
    return ListWithLength<Document>.fromJson(
        json.decode(response.body), (dynamic json) => Document.fromJson(json));
  }

  Future<List<Document>> getDocumentVersions(int documentId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Document/versions/$documentId'),
      headers: _api.getHeaders(),
    );
    return List<Document>.from(
      (json.decode(response.body)["items"]).map(
        (model) => Document.fromJson(model),
      ),
    );
  }

  Future<List<RelatedItem>> getGlobalSearch(String query) async {
    Response response;
    response = await _api.client.post(
      Uri.parse('${_api.getBaseUrl()}/api/search'),
      headers: _api.getHeaders(),
      body: jsonEncode(GlobalSearchQuery(query: query, mode: 4)),
    );

    return List<RelatedItem>.from(
      (json.decode(response.body)).map(
        (model) => RelatedItem.fromJson(model),
      ),
    );
  }

  Future<Document> getDocument(int documentId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Document/$documentId'),
      headers: _api.getHeaders(),
    );
    return Document.fromJson(json.decode(response.body));
  }

  Future<List<DocumentAttachmentFile>> getDocumentAttachmentFiles(
      int documentId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Document/$documentId/attachment'),
      headers: _api.getHeaders(),
    );
    return List<DocumentAttachmentFile>.from(
      (json.decode(response.body)).map(
        (model) => DocumentAttachmentFile.fromJson(model),
      ),
    );
  }

  Future<List<DocumentType>> getDocumentsTypes() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Dictionary/document/types'),
      headers: _api.getHeaders(),
    );
    return List<DocumentType>.from(
      (json.decode(response.body)).map(
        (model) => DocumentType.fromJson(model),
      ),
    );
  }

  List<FileType> getFileTypes() {
    return _fileTypes;
  }

  @override
  List<SystemFilter> getSystemFilters() {
    return _systemFilters;
  }

  @override
  Future<List<MyFilter>> getMyFilters() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Filter/documentGrid'),
      headers: _api.getHeaders(),
    );
    return List<MyFilter>.from(
      (json.decode(response.body)).map(
        (model) => MyFilter.fromJson(model),
      ),
    );
  }

  Future<List<DocumentState>> getDocumentStates(int documentTypeId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse(
          '${_api.getBaseUrl()}/api/Dictionary/document/$documentTypeId/states'),
      headers: _api.getHeaders(),
    );
    return List<DocumentState>.from(
      (json.decode(response.body)).map(
        (model) => DocumentState.fromJson(model),
      ),
    );
  }

  Future<List<Document>> getRelDocumentsForDocument(int documentId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/documents/document/$documentId'),
      headers: _api.getHeaders(),
    );
    return List<Document>.from(
      (json.decode(response.body)).map(
        (model) => Document.fromJson(model),
      ),
    );
  }

  Future<List<Document>> getRelDocumentsForFolder(int folderId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/documents/folder/$folderId'),
      headers: _api.getHeaders(),
    );
    return List<Document>.from(
      (json.decode(response.body)).map(
        (model) => Document.fromJson(model),
      ),
    );
  }

  Future<List<Document>> getRelDocumentsForContact(int contactId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Link/documents/contact/$contactId'),
      headers: _api.getHeaders(),
    );
    return List<Document>.from(
      (json.decode(response.body)).map(
        (model) => Document.fromJson(model),
      ),
    );
  }

  Future<String> downloadToTempFile(int documentId, String fileName) async {
    Response response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Document/$documentId/file'),
      headers: _api.getHeaders(),
    );
    if (response.statusCode == 200) {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = await File(filePath).create();
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Error();
    }
  }

  Future<List<HistoryAction>> getDocumentHistory(int documentId) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/Document/$documentId/actions'),
      headers: _api.getHeaders(),
    );
    return List<HistoryAction>.from(
      (json.decode(response.body)).map(
        (model) => HistoryAction.fromJson(model),
      ),
    );
  }

  Future<String> downloadToTempAttachmentFile(
      DocumentAttachmentFile file) async {
    Response response = await _api.client.get(
      Uri.parse(
          '${_api.getBaseUrl()}/api/Document/${file.documentId}/attachment/${file.documentAttachmentId}/file'),
      headers: _api.getHeaders(),
    );
    if (response.statusCode == 200) {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${file.fileName}';
      final newTempFile = await File(filePath).create();
      await newTempFile.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Error();
    }
  }

  Future<List<String>> downloadToTempDocument(Document document) async {
    List<Future<String>> actions = [];
    if (document.fileName != null) {
      actions.add(
        downloadToTempFile(
          document.documentId,
          document.fileName!,
        ),
      );
    }
    List<DocumentAttachmentFile> attachments =
        await getDocumentAttachmentFiles(document.documentId);
    for (DocumentAttachmentFile attachment in attachments) {
      actions.add(
        downloadToTempAttachmentFile(
          attachment,
        ),
      );
    }
    return await Future.wait(actions);
  }

  Future<List<String>> downloadToTempDocuments(List<Document> documents) async {
    List<Future<List<String>>> actions = [];
    for (Document document in documents) {
      actions.add(downloadToTempDocument(document));
    }
    return (await Future.wait(actions)).expand((element) => element).toList();
  }

  static final List<FileType> _fileTypes = [
    FileType(name: "MS Word", value: '.docx'),
    FileType(name: "MS Excel", value: '.xls'),
    FileType(name: "MS Power Point", value: '.pptx'),
    FileType(name: "Plik skompresowany", value: '.zip'),
    FileType(name: "PDF", value: '.pdf'),
    FileType(name: "Plik tekstowy", value: '.txt'),
    FileType(name: "Grafika(jpg)", value: '.jpg'),
    FileType(name: "Grafika(tif)", value: '.tif'),
    FileType(name: "Grafika(bmp)", value: '.bmp'),
    FileType(name: "Strona sieci WEB", value: '.html'),
    FileType(name: "Wiadomość programu Outlook", value: '.msg'),
  ];

  static final List<SystemFilter> _systemFilters = [
    SystemFilter(name: "Wszystko", value: "ALL"),
    SystemFilter(name: "Utworzyłem", value: "CREATOR_ME"),
    SystemFilter(
        name: "AKCEPTACJA: Moje - oczekujące", value: "REQUEST_WAITING"),
    SystemFilter(
        name: "AKCEPTACJA: Moje - decyzja pozytywna",
        value: "REQUEST_POSITIVE"),
    SystemFilter(
        name: "AKCEPTACJA: Moje - decyzja negatywna",
        value: "REQUEST_NEGATIVE"),
    SystemFilter(name: "AKCEPTACJA: Moje - wszystkie", value: "REQUEST_ALL"),
    SystemFilter(name: "OBSŁUGA: Moje - nowe", value: "LETTER_NEW"),
    SystemFilter(name: "OBSŁUGA: Moje - w toku", value: "LETTER_ACCEPTED"),
    SystemFilter(name: "OBSŁUGA: Moje - załatwione", value: "LETTER_DONE"),
    SystemFilter(
        name: "OBSŁUGA: Moje - przekazane", value: "LETTER_TRANSFERED"),
    SystemFilter(name: "OBSŁUGA: Moje - odrzucone", value: "LETTER_REJECTED"),
    SystemFilter(name: "OBSŁUGA: Moje - wszystkie", value: "LETTER_ALL"),
  ];
}
