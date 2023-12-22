import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/services/interfaces/my_filters_service.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyFilterSearchPage extends StatefulWidget {
  const MyFilterSearchPage({
    super.key,
    required this.service,
  });

  final MyFiltersService service;

  @override
  State<MyFilterSearchPage> createState() => _MyFilterSearchPageState();
}

class _MyFilterSearchPageState extends State<MyFilterSearchPage> {
  List<MyFilter> _filterData(List<MyFilter> filters, String? pattern) {
    if (pattern == null) return filters;
    pattern = pattern.toLowerCase();
    return filters
        .where((filter) => filter.filterName.toLowerCase().contains(pattern!))
        .toList();
  }

  void _onSelected(MyFilter type) {
    context.pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<MyFilter>(
      fetchData: widget.service.getMyFilters(),
      filterData: _filterData,
      listTileBuilder: (MyFilter filter) => ListTile(
        leading: const Icon(Icons.favorite_outline),
        title: Text(filter.filterName),
        onTap: () => _onSelected(filter),
      ),
      autofocus: false,
    );
  }
}
