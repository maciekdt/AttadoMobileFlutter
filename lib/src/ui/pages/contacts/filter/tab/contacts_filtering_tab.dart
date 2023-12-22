import 'package:attado_mobile/src/ui/common/navigations/bottom_navigation_filter.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/common/tabs/tab_with_counter.dart';
import 'package:attado_mobile/src/ui/pages/contacts/filter/filter_forms/contacts_custom_filtering_form.dart';
import 'package:attado_mobile/src/ui/pages/contacts/filter/filter_forms/contacts_standard_filetring_form.dart';
import 'package:attado_mobile/src/ui/pages/contacts/providers/contacts_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ContactsFilteringTab extends StatefulWidget {
  const ContactsFilteringTab({super.key});

  @override
  State<StatefulWidget> createState() => _ContactsFilteringTabState();
}

class _ContactsFilteringTabState extends State<ContactsFilteringTab> {
  UniqueKey _stdFilterFormKey = UniqueKey();
  late ContactsOptionsProvider _optionsProvider;

  void _clear() {
    _optionsProvider.resetAllFilters();
    setState(() {
      _stdFilterFormKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context).showBottomNavigation = false;
    _optionsProvider = Provider.of<ContactsOptionsProvider>(context);

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
            ContactsStandardFilteringForm(key: _stdFilterFormKey),
            const ContactsCustomFilteringForm(),
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
