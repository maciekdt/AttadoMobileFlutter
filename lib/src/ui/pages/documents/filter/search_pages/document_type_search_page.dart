import 'package:attado_mobile/src/models/data_models/documents/document_type.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentTypeSearchPage extends StatefulWidget {
  const DocumentTypeSearchPage({
    super.key,
    required this.documentsService,
  });

  final DocumentsService documentsService;

  @override
  State<DocumentTypeSearchPage> createState() => _DocumentTypeSearchPageState();
}

class _DocumentTypeSearchPageState extends State<DocumentTypeSearchPage> {
  List<DocumentType> _filterData(List<DocumentType> types, String? pattern) {
    if (pattern == null) return types;
    pattern = pattern.toLowerCase();
    return types
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(DocumentType type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<DocumentType>(
      fetchData: widget.documentsService.getDocumentsTypes(),
      filterData: _filterData,
      listTileBuilder: (DocumentType type) => ListTile(
        leading: const Icon(Icons.description_outlined),
        title: Text(type.name),
        onTap: () => _onSelected(type),
      ),
    );
  }
}
