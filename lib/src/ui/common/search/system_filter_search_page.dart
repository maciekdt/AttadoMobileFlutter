import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/services/interfaces/system_filters_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SystemFilterSearchPage extends StatefulWidget {
  const SystemFilterSearchPage({
    super.key,
    required this.service,
  });

  final SystemFiltersService service;

  @override
  State<SystemFilterSearchPage> createState() => _SystemFilterSearchPageState();
}

class _SystemFilterSearchPageState extends State<SystemFilterSearchPage> {
  List<SystemFilter> _filterData(List<SystemFilter> filters, String? pattern) {
    if (pattern == null) return filters;
    pattern = pattern.toLowerCase();
    return filters
        .where((type) => type.name.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(SystemFilter type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<SystemFilter>(
      fetchData: widget.service.getSystemFilters(),
      filterData: _filterData,
      listTileBuilder: (SystemFilter filter) => ListTile(
        leading: const Icon(Icons.filter_alt_outlined),
        title: Text(filter.name),
        onTap: () => _onSelected(filter),
      ),
      autofocus: false,
    );
  }
}
