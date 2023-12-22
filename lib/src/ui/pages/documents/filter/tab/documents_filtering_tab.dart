import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/navigations/bottom_navigation_filter.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/common/tabs/tab_with_counter.dart';
import 'package:attado_mobile/src/ui/pages/documents/filter/filter_forms/documents_standard_filtering_form.dart';
import 'package:attado_mobile/src/ui/pages/documents/providers/documents_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../filter_forms/documents_custom_filtering_form.dart';

class DocumentsFilteringTab extends StatefulWidget {
  const DocumentsFilteringTab({
    super.key,
    required this.documentsService,
  });
  final DocumentsService documentsService;

  @override
  State<StatefulWidget> createState() => _DocumentsFilteringTabState();
}

class _DocumentsFilteringTabState extends State<DocumentsFilteringTab> {
  UniqueKey _stdFilterFormKey = UniqueKey();
  late DocumentsOptionsProvider _optionsProvider;

  void _clear() {
    _optionsProvider.resetAllFilters();
    setState(() {
      _stdFilterFormKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context).showBottomNavigation = false;
    _optionsProvider = Provider.of<DocumentsOptionsProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Filtrowanie"),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: [
              TabWithCounter(
                label: "Filtr standardowy",
                value: _optionsProvider.standardFiltersCount,
                showOnZero: false,
              ),
              TabWithCounter(
                label: "Zapisane filtry",
                value: _optionsProvider.customFiltersCount,
                showOnZero: false,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DocumentsStandardFilteringForm(
              key: _stdFilterFormKey,
              documentsService: widget.documentsService,
            ),
            DocumentsCustomFilteringForm(
                documentsService: widget.documentsService),
          ],
        ),
        bottomNavigationBar: BottomNavigationFilter(
          onClear: _clear,
          onSubmit: () => context.pop(),
        ),
      ),
    );
  }
}
