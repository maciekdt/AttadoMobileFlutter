import 'dart:async';
import 'dart:io';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/appbars/search_app_bar.dart';
import 'package:attado_mobile/src/ui/common/badges/counter_badge.dart';
import 'package:attado_mobile/src/ui/common/dialogs/cancelable_loading_dialog.dart';
import 'package:attado_mobile/src/ui/common/exceptions/client_exception_footer.dart';
import 'package:attado_mobile/src/ui/common/exceptions/client_exception_page.dart';
import 'package:attado_mobile/src/ui/common/exceptions/offline_exception_footer.dart';
import 'package:attado_mobile/src/ui/common/exceptions/offline_exception_page.dart';
import 'package:attado_mobile/src/ui/common/icon_buttons/filter_icon_button.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/pages/documents/list/documents_list_item.dart';
import 'package:attado_mobile/src/ui/pages/documents/providers/documents_options_provider.dart';
import 'package:attado_mobile/src/ui/pages/documents/providers/selected_documents_provider.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DocumentsListPage extends StatefulWidget {
  const DocumentsListPage({
    super.key,
    required this.service,
    required this.authRepo,
  });
  final DocumentsService service;
  final AuthRepo authRepo;

  @override
  State<DocumentsListPage> createState() => _DocumentsListPageState();
}

class _DocumentsListPageState extends State<DocumentsListPage> {
  final _numberOfPostsPerRequest = 10;
  final PagingController<int, Document> _pagingController =
      PagingController(firstPageKey: 1);
  late DocumentsOptionsProvider _optionsProvider;
  late AppProvider _appProvider;
  late SelectedDocumentsProvider _selectionProvider;
  int? _itemsCount;
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
      if (_appProvider.documentsListFirstRun) {
        await _optionsProvider.setStartFilter();
        _appProvider.documentsListFirstRun = false;
      }
      final documentsList = await widget.service.getDocuments(
        pageKey,
        _optionsProvider.options,
        _optionsProvider.myFilter?.filterValue,
        _searchQuery,
      );
      setState(() {
        _itemsCount = documentsList.totalElements;
      });

      final isLastPage = documentsList.items.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(documentsList.items);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(documentsList.items, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  Future<void> _goToFilter() async {
    await context.push("/documents/filter");
    _pagingController.refresh();
  }

  void _cancelSelection() {
    _selectionProvider.unselectAll();
  }

  Future<void> _share() async {
    StreamSubscription<List<String>> stream = widget.service
        .downloadToTempDocuments(_selectionProvider.selectedDocuments)
        .asStream()
        .listen(
      (List<String> paths) async {
        List<XFile> xFiles = paths.map((path) => XFile(path)).toList();
        await Share.shareXFiles(xFiles);
        _popLoadingDialog();
        _selectionProvider.unselectAll();
      },
    );
    _showLoadingDialog(stream);
  }

  void _showLoadingDialog(StreamSubscription<Object> stream) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return CancelableLoadingDialog(
          message: "Udostępnianie plików...",
          onCancel: () {
            stream.cancel();
            _popLoadingDialog();
          },
        );
      },
    );
  }

  void _popLoadingDialog() {
    context.pop();
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

  PreferredSizeWidget? _getAppBar() {
    if (_selectionProvider.selectedDocumentsNumber != 0) {
      return AppBar(
        leading: IconButton(
          onPressed: _cancelSelection,
          icon: const Icon(Icons.close),
        ),
        title: Text("Zaznaczono ${_selectionProvider.selectedDocumentsNumber}"),
        actions: [
          IconButton(
            onPressed: _share,
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      );
    } else if (_search) {
      return PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
        child: SearchAppBar(
          cancelSearch: _cancelSearch,
          onTextChanged: _onTextChanged,
        ),
      );
    } else {
      return AppBar(
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
            Text("eDokumenty",
                style: Theme.of(context).appBarTheme.titleTextStyle),
            Padding(
              padding: const EdgeInsets.only(left: 3, bottom: 12),
              child: CounterBadge(
                value: _itemsCount,
                maxValue: null,
                background: Theme.of(context).brightness == Brightness.light
                    ? AppColors.documentConLight
                    : AppColors.documentConDark,
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _optionsProvider = Provider.of<DocumentsOptionsProvider>(context);
    _selectionProvider = Provider.of<SelectedDocumentsProvider>(context);
    _appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.documentBackgroundLight
          : AppColors.documentBackgroundDark,
      appBar: _getAppBar(),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() {
          _pagingController.refresh();
        }),
        child: PagedListView<int, Document>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Document>(
            itemBuilder: (context, item, index) {
              return DocumentsListItem(document: item);
            },
            noItemsFoundIndicatorBuilder: (context) {
              return Center(
                child: Text(
                  "Brak dokumentów",
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
