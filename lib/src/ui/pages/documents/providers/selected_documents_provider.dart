import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:flutter/material.dart';

class SelectedDocumentsProvider extends ChangeNotifier {
  final Set<Document> _selectedDocuments = {};
  List<Document> get selectedDocuments => _selectedDocuments.toList();

  bool isDocumentSelected(Document document) {
    return _selectedDocuments.contains(document);
  }

  int get selectedDocumentsNumber => _selectedDocuments.length;

  void selectDocument(Document document) {
    _selectedDocuments.add(document);
    notifyListeners();
  }

  void unselectDocument(Document document) {
    _selectedDocuments.remove(document);
    notifyListeners();
  }

  void unselectAll() {
    _selectedDocuments.clear();
    notifyListeners();
  }
}
