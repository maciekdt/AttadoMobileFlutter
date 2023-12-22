import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_details.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:flutter/cupertino.dart';

class TaskDetailsProvider extends ChangeNotifier {
  TaskDetailsProvider({
    required this.task,
  }) {
    init();
  }

  final Task task;
  final TasksService _tasksService = getIt<TasksService>();

  Future<void> init() async {
    List<Future<void>> futures = [
      Future.microtask(() async =>
          _details = await _tasksService.getTaskDetails(task.taskId)),
      _loadRel(),
    ];
    await Future.wait(futures);
    notifyListeners();
  }

  TaskDetails? _details;
  TaskDetails? get details => _details;

  Future<void> loadDetails() async {
    _details = null;
    notifyListeners();
    _details = await _tasksService.getTaskDetails(task.taskId);
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
      /*Future.microtask(
        () async => _relDocuments =
            await _documentsService.getRelDocumentsForFolder(task.folderId),
      ),
      Future.microtask(
        () async => _relFolders =
            await _foldersService.getRelFoldersForFolder(task.folderId),
      ),
      Future.microtask(
        () async => _relContacts =
            await _contactsService.getRelContactsForFolder(task.folderId),
      ),
      Future.microtask(
        () async => _relTasks =
            await _tasksService.getRelTasksForFolder(task.folderId),
      ),*/
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
