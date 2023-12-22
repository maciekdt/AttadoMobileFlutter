import 'package:attado_mobile/src/models/data_models/documents/document_state.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentStateSearchPage extends StatefulWidget {
  const DocumentStateSearchPage({
    super.key,
    required this.documentsService,
    required this.documentTypeId,
  });

  final DocumentsService documentsService;
  final int documentTypeId;

  @override
  State<DocumentStateSearchPage> createState() =>
      _DocumentStateSearchPageState();
}

class _DocumentStateSearchPageState extends State<DocumentStateSearchPage> {
  List<DocumentState> _filterData(List<DocumentState> types, String? pattern) {
    if (pattern == null) return types;
    pattern = pattern.toLowerCase();
    return types
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(DocumentState type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<DocumentState>(
      fetchData:
          widget.documentsService.getDocumentStates(widget.documentTypeId),
      filterData: _filterData,
      listTileBuilder: (DocumentState state) => ListTile(
        leading: const Icon(Icons.content_paste_search_outlined),
        title: Text(state.name),
        onTap: () => _onSelected(state),
      ),
    );
  }
}
