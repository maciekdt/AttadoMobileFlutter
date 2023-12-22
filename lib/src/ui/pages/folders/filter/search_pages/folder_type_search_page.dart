import 'package:attado_mobile/src/models/data_models/folders/folder_type.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FolderTypeSearchPage extends StatefulWidget {
  const FolderTypeSearchPage({
    super.key,
    required this.foldersService,
  });

  final FoldersService foldersService;

  @override
  State<FolderTypeSearchPage> createState() => _FolderTypeSearchPageState();
}

class _FolderTypeSearchPageState extends State<FolderTypeSearchPage> {
  List<FolderType> _filterData(List<FolderType> types, String? pattern) {
    if (pattern == null) return types;
    pattern = pattern.toLowerCase();
    return types
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(FolderType type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<FolderType>(
      fetchData: widget.foldersService.getFoldersTypes(),
      filterData: _filterData,
      listTileBuilder: (FolderType type) => ListTile(
        leading: const Icon(Icons.folder_outlined),
        title: Text(type.name),
        onTap: () => _onSelected(type),
      ),
    );
  }
}
