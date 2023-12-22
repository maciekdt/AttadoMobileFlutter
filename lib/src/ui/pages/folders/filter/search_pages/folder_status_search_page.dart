import 'package:attado_mobile/src/models/data_models/folders/folder_status.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FolderStatusSearchPage extends StatefulWidget {
  const FolderStatusSearchPage({
    super.key,
    required this.foldersService,
    required this.folderTypeId,
  });

  final FoldersService foldersService;
  final int folderTypeId;

  @override
  State<FolderStatusSearchPage> createState() => _FolderStatusSearchPageState();
}

class _FolderStatusSearchPageState extends State<FolderStatusSearchPage> {
  List<FolderStatus> _filterData(List<FolderStatus> types, String? pattern) {
    if (pattern == null) return types;
    pattern = pattern.toLowerCase();
    return types
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(FolderStatus type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<FolderStatus>(
      fetchData:
          widget.foldersService.getFoldersStatesForType(widget.folderTypeId),
      filterData: _filterData,
      listTileBuilder: (FolderStatus type) => ListTile(
        leading: const Icon(Icons.content_paste_search_outlined),
        title: Text(type.name),
        onTap: () => _onSelected(type),
      ),
    );
  }
}
