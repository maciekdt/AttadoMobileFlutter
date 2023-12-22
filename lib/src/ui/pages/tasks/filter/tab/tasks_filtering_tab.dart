import 'package:attado_mobile/src/ui/common/navigations/bottom_navigation_filter.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/common/tabs/tab_with_counter.dart';
import 'package:attado_mobile/src/ui/pages/tasks/filter/filter_forms/tasks_custom_filtering_form.dart';
import 'package:attado_mobile/src/ui/pages/tasks/filter/filter_forms/tasks_standard_filtering_form.dart';
import 'package:attado_mobile/src/ui/pages/tasks/providers/tasks_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TasksFilteringTab extends StatefulWidget {
  const TasksFilteringTab({super.key});

  @override
  State<StatefulWidget> createState() => _TasksFilteringTabState();
}

class _TasksFilteringTabState extends State<TasksFilteringTab> {
  UniqueKey _stdFilterFormKey = UniqueKey();
  late TasksOptionsProvider _optionsProvider;

  void _clear() {
    _optionsProvider.resetAllFilters();
    setState(() {
      _stdFilterFormKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context).showBottomNavigation = false;
    _optionsProvider = Provider.of<TasksOptionsProvider>(context);

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
            TasksStandardFilteringForm(key: _stdFilterFormKey),
            const TasksCustomFilteringForm(),
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
