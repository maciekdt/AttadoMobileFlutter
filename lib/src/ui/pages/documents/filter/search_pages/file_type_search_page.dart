import 'package:attado_mobile/src/models/data_models/documents/file_type.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FileTypeSearchPage extends StatefulWidget {
  const FileTypeSearchPage({
    super.key,
    required this.documentsService,
  });

  final DocumentsService documentsService;

  @override
  State<FileTypeSearchPage> createState() => _FileTypeSearchPageState();
}

class _FileTypeSearchPageState extends State<FileTypeSearchPage> {
  List<FileType> _filterData(List<FileType> types, String? pattern) {
    if (pattern == null) return types;
    pattern = pattern.toLowerCase();
    return types
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(FileType type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<FileType>(
      fetchData: widget.documentsService.getFileTypes(),
      filterData: _filterData,
      listTileBuilder: (FileType type) => ListTile(
        leading: const Icon(Icons.file_open_outlined),
        title: Text(type.name),
        subtitle: Text(type.value),
        onTap: () => _onSelected(type),
      ),
    );
  }
}
