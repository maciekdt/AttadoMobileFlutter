import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/common/history_action.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/models/data_models/documents/document_attachment_file.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/services/contacts_service.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:flutter/material.dart';

class DocumentDetailsProvider extends ChangeNotifier {
  DocumentDetailsProvider({
    required this.document,
  }) {
    init();
  }

  final Document document;
  final DocumentsService _documentsService = getIt<DocumentsService>();
  final FoldersService _foldersService = getIt<FoldersService>();
  final ContactsService _contactsService = getIt<ContactsService>();
  final TasksService _tasksService = getIt<TasksService>();

  Future<void> init() async {
    List<Future<void>> futures = [
      Future.microtask(() async => _versions =
          await _documentsService.getDocumentVersions(document.documentId)),
      Future.microtask(() async => _attachment = await _documentsService
          .getDocumentAttachmentFiles(document.documentId)),
      Future.microtask(() async => _history =
          await _documentsService.getDocumentHistory(document.documentId)),
      _loadRel(),
    ];
    await Future.wait(futures);
    notifyListeners();
  }

  List<Document>? _versions;
  List<Document>? get versions => _versions;

  Future<void> loadVersions() async {
    _versions = null;
    notifyListeners();
    _versions =
        await _documentsService.getDocumentVersions(document.documentId);
    notifyListeners();
  }

  List<DocumentAttachmentFile>? _attachment;
  List<DocumentAttachmentFile>? get attachment => _attachment;

  Future<void> loadAttachment() async {
    _attachment = null;
    notifyListeners();
    _attachment =
        await _documentsService.getDocumentAttachmentFiles(document.documentId);
    notifyListeners();
  }

  List<HistoryAction>? _history;
  List<HistoryAction>? get history => _history;

  Future<void> loadHistory() async {
    _history = null;
    notifyListeners();
    _history = await _documentsService.getDocumentHistory(document.documentId);
    notifyListeners();
  }

  bool _relLoaded = false;
  bool get relLoaded => _relLoaded;

  int? get relNumber {
    int count = 0;
    if (!_relLoaded) {
      return null;
    }
    if (_relDocuments != null) {
      count += _relDocuments!.length;
    }
    if (_relFolders != null) {
      count += _relFolders!.length;
    }
    if (_relContacts != null) {
      count += _relContacts!.length;
    }
    if (_relTasks != null) {
      count += _relTasks!.length;
    }
    return count;
  }

  List<Document>? _relDocuments;
  List<Document>? get relDocuments => _relDocuments;

  List<Folder>? _relFolders;
  List<Folder>? get relFolders => _relFolders;

  List<Contact>? _relContacts;
  List<Contact>? get relContacts => _relContacts;

  List<Task>? _relTasks;
  List<Task>? get relTasks => _relTasks;

  Future<void> _loadRel() async {
    List<Future<void>> futures = [
      Future.microtask(() async => _relDocuments = await _documentsService
          .getRelDocumentsForDocument(document.documentId)),
      Future.microtask(() async => _relFolders =
          await _foldersService.getRelFoldersForDocument(document.documentId)),
      Future.microtask(() async => _relContacts = await _contactsService
          .getRelContactsForDocument(document.documentId)),
      Future.microtask(() async => _relTasks =
          await _tasksService.getRelTasksForDocument(document.documentId)),
    ];
    await Future.wait(futures);
    _relLoaded = true;
  }
}
