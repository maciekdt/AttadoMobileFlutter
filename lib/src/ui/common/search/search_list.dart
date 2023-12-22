import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchList<T> extends StatefulWidget {
  const SearchList({
    super.key,
    required this.fetchData,
    required this.listTileBuilder,
    required this.filterData,
    this.autofocus = true,
  });
  final FutureOr<List<T>> fetchData;
  final List<T> Function(List<T> elements, String? pattern) filterData;
  final ListTile Function(T element) listTileBuilder;
  final bool autofocus;

  @override
  State<StatefulWidget> createState() => _SearchListState<T>();
}

class _SearchListState<T> extends State<SearchList<T>> {
  List<T> _elements = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _filterList(null);
  }

  void _filterList(String? pattern) async {
    setState(() {
      _loading = true;
    });
    var elements = widget.filterData(await widget.fetchData, pattern);
    setState(() {
      _loading = false;
      _elements = elements;
    });
  }

  void _goBack() {
    context.pop(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            onChanged: _filterList,
            autofocus: widget.autofocus,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
                onPressed: _goBack,
              ),
              border: const OutlineInputBorder(),
              hintText: 'Szukaj...',
              focusedBorder: null,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _loading
            ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : _elements.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "Brak elementów",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _elements.length,
                      itemBuilder: (BuildContext context, int index) {
                        return widget.listTileBuilder(_elements[index]);
                      },
                    ),
                  )
      ],
    );
  }
}
