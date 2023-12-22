import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.cancelSearch,
    required this.onTextChanged,
  });

  final Future<void> Function(String? text) onTextChanged;
  final void Function() cancelSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 3.0,
        right: 10,
        left: 10,
        bottom: 5,
      ),
      child: TextFormField(
        onChanged: onTextChanged,
        autofocus: true,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: const Icon(
              Icons.close,
              size: 28,
            ),
            onPressed: cancelSearch,
          ),
          border: const OutlineInputBorder(),
          hintText: 'Szukaj...',
          focusedBorder: null,
        ),
      ),
    );
  }
}
