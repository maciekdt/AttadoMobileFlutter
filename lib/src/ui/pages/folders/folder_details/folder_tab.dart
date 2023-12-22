import 'package:attado_mobile/src/models/data_models/common/item_type.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/ui/common/tabs/tab_with_counter.dart';
import 'package:attado_mobile/src/ui/pages/folders/folder_details/details/folder_details_page.dart';
import 'package:attado_mobile/src/ui/pages/folders/folder_details/folder_details_provider.dart';
import 'package:attado_mobile/src/ui/pages/folders/folder_details/history/folder_history_page.dart';
import 'package:attado_mobile/src/ui/pages/folders/folder_details/related/folder_related_objects_page.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FolderTab extends StatefulWidget {
  const FolderTab({
    super.key,
    required this.folder,
  });
  final Folder folder;

  @override
  State<StatefulWidget> createState() => _FolderTabState();
}

class _FolderTabState extends State<FolderTab> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FolderDetailsProvider(folder: widget.folder),
      child: Consumer<FolderDetailsProvider>(
        builder: (context, provider, child) => DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                leadingWidth: 40,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 3, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.folder.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 14.5),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.folder.folderNumber,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  tabAlignment: TabAlignment.fill,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor:
                      Theme.of(context).brightness == Brightness.light
                          ? AppColors.folderLight
                          : AppColors.folderDark,
                  labelColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.folderLight
                      : AppColors.folderDark,
                  tabs: [
                    const Tab(child: Icon(Icons.folder_outlined)),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 7.5),
                      child: TabWithCounter(
                        label: "Powiązane",
                        value: provider.relNumber,
                        itemType: ItemType.folder,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 7.5),
                      child: TabWithCounter(
                        label: "Historia",
                        value: provider.history?.length,
                        itemType: ItemType.folder,
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  FolderDetailsPage(folder: widget.folder),
                  FolderRelatedObjectsPage(folder: widget.folder),
                  const FolderHistoryPage(),
                ],
              )),
        ),
      ),
    );
  }
}
