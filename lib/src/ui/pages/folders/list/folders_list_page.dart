import 'dart:async';
import 'dart:io';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/ui/common/appbars/search_app_bar.dart';
import 'package:attado_mobile/src/ui/common/badges/counter_badge.dart';
import 'package:attado_mobile/src/ui/common/exceptions/client_exception_footer.dart';
import 'package:attado_mobile/src/ui/common/exceptions/client_exception_page.dart';
import 'package:attado_mobile/src/ui/common/exceptions/offline_exception_footer.dart';
import 'package:attado_mobile/src/ui/common/exceptions/offline_exception_page.dart';
import 'package:attado_mobile/src/ui/common/icon_buttons/filter_icon_button.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/pages/folders/list/folder_list_item.dart';
import 'package:attado_mobile/src/ui/pages/folders/providers/folders_options_provider.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class FoldersListPage extends StatefulWidget {
  const FoldersListPage({
    super.key,
    required this.foldersService,
    required this.authRepo,
  });
  final FoldersService foldersService;
  final AuthRepo authRepo;

  @override
  State<FoldersListPage> createState() => _FoldersListPageState();
}

class _FoldersListPageState extends State<FoldersListPage> {
  final _numberOfPostsPerRequest = 10;
  final PagingController<int, Folder> _pagingController =
      PagingController(firstPageKey: 1);
  int? _itemsCount;
  late FoldersOptionsProvider _optionsProvider;
  late AppProvider _appProvider;
  bool _search = false;
  String? _searchQuery;
  StreamSubscription<void>? _lastSearchAction;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (_appProvider.foldersListFirstRun) {
        await _optionsProvider.setStartFilter();
        _appProvider.foldersListFirstRun = false;
      }
      final foldersList = await widget.foldersService.getFolders(
        pageKey,
        _optionsProvider.options,
        _optionsProvider.myFilter?.filterValue,
        _searchQuery,
      );
      setState(() {
        _itemsCount = foldersList.totalElements;
      });
      final isLastPage = foldersList.items.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(foldersList.items);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(foldersList.items, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  Future<void> _goToFilter() async {
    await context.push("/folders/filter");
    _pagingController.refresh();
  }

  Future<void> _onTextChanged(String? text) async {
    if (text != null) {
      setState(() {
        _searchQuery = text;
      });
    }
    if (_lastSearchAction != null) {
      _lastSearchAction!.cancel();
    }
    _lastSearchAction =
        Future.delayed(const Duration(seconds: 1)).asStream().listen((_) {
      _pagingController.refresh();
    });
  }

  void _cancelSearch() {
    setState(() {
      _searchQuery = null;
      _search = false;
    });
    _pagingController.refresh();
  }

  void _startSearch() {
    setState(() {
      _search = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _optionsProvider = Provider.of<FoldersOptionsProvider>(context);
    _appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.folderBackgroundLight
          : AppColors.folderBackgroundDark,
      appBar: !_search
          ? AppBar(
              leadingWidth: 200,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 2),
                  const Image(
                    image: AssetImage('assets/icon.png'),
                    width: 40,
                  ),
                  Text("eSprawy",
                      style: Theme.of(context).appBarTheme.titleTextStyle),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 12),
                    child: CounterBadge(
                      value: _itemsCount,
                      maxValue: null,
                      background:
                          Theme.of(context).brightness == Brightness.light
                              ? AppColors.folderConLight
                              : AppColors.folderConDark,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: _startSearch,
                  icon: const Icon(Icons.search),
                ),
                FilterIconButton(
                  filtersCount: _optionsProvider.filtersCount,
                  onTap: _goToFilter,
                ),
              ],
            )
          : PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height),
              child: SearchAppBar(
                cancelSearch: _cancelSearch,
                onTextChanged: _onTextChanged,
              ),
            ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() {
          _pagingController.refresh();
        }),
        child: PagedListView<int, Folder>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Folder>(
            itemBuilder: (context, item, index) {
              return FolderListItem(folder: item);
            },
            noItemsFoundIndicatorBuilder: (context) {
              return Center(
                child: Text(
                  "Brak eSpraw",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (_) {
              if (_pagingController.error is SocketException) {
                return OfflineExceptionPage(
                  onRefresh: () => _pagingController.refresh(),
                );
              } else {
                return ClientExceptionPage(
                  onRefresh: () => _pagingController.refresh(),
                );
              }
            },
            newPageErrorIndicatorBuilder: (_) {
              if (_pagingController.error is SocketException) {
                return OfflineExceptionFooter(
                  onRefresh: () => _pagingController.retryLastFailedRequest(),
                );
              } else {
                return ClientExceptionFooter(
                  onRefresh: () => _pagingController.retryLastFailedRequest(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
