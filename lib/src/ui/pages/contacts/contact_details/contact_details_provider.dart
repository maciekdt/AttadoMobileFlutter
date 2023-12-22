import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/common/history_action.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/services/contacts_service.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:flutter/cupertino.dart';

class ContactDetailsProvider extends ChangeNotifier {
  ContactDetailsProvider({
    required this.contact,
  }) {
    init();
  }

  final Contact contact;
  final FoldersService _foldersService = getIt<FoldersService>();
  final DocumentsService _documentsService = getIt<DocumentsService>();
  final ContactsService _contactsService = getIt<ContactsService>();
  final TasksService _tasksService = getIt<TasksService>();

  Future<void> init() async {
    List<Future<void>> futures = [
      Future.microtask(() async => _history =
          await _contactsService.getContactHistory(contact.contactId)),
      _loadRel(),
    ];
    await Future.wait(futures);
    notifyListeners();
  }

  List<HistoryAction>? _history;
  List<HistoryAction>? get history => _history;

  Future<void> loadHistory() async {
    _history = null;
    notifyListeners();
    _history = await _contactsService.getContactHistory(contact.contactId);
    notifyListeners();
  }

  bool _relLoaded = false;
  bool get relLoaded => _relLoaded;

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
      Future.microtask(
        () async => _relDocuments = await _documentsService
            .getRelDocumentsForContact(contact.contactId),
      ),
      Future.microtask(
        () async => _relFolders =
            await _foldersService.getRelFoldersForContact(contact.contactId),
      ),
      Future.microtask(
        () async => _relContacts =
            await _contactsService.getRelContactsForContact(contact.contactId),
      ),
      Future.microtask(
        () async => _relTasks =
            await _tasksService.getRelTasksForContact(contact.contactId),
      ),
    ];
    await Future.wait(futures);
    _relLoaded = true;
  }

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
}
