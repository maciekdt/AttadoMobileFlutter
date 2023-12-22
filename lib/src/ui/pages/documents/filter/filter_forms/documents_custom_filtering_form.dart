// ignore_for_file: use_build_context_synchronously

import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';
import 'package:attado_mobile/src/models/data_models/filters/system_filter.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/containers/select_field_container.dart';
import 'package:attado_mobile/src/ui/pages/documents/providers/documents_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DocumentsCustomFilteringForm extends StatefulWidget {
  const DocumentsCustomFilteringForm({
    super.key,
    required this.documentsService,
  });

  final DocumentsService documentsService;

  @override
  State<StatefulWidget> createState() => _DocumentsCustomFilteringFormState();
}

class _DocumentsCustomFilteringFormState
    extends State<DocumentsCustomFilteringForm> {
  late DocumentsOptionsProvider _optionsProvider;

  void _selectMyFilter() async {
    var result = await context.push("/documents/filter/my-filter");
    if (result != null) {
      _optionsProvider.myFilter = result as MyFilter;
      context.pop();
    }
  }

  void _unselectMyFilter() {
    _optionsProvider.myFilter = null;
  }

  void _selectSystemFilter() async {
    var result = await context.push("/documents/filter/system-filter");
    if (result != null) {
      _optionsProvider.systemFilter = result as SystemFilter;
      context.pop();
    }
  }

  void _unselectSystemFilter() {
    _optionsProvider.systemFilter = null;
  }

  @override
  Widget build(BuildContext context) {
    _optionsProvider =
        Provider.of<DocumentsOptionsProvider>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectSystemFilter,
              prefixIcon: Icons.filter_alt_outlined,
              text: _optionsProvider.systemFilter == null
                  ? Text(
                      "Stałe wyszukiwania",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.systemFilter!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.systemFilter == null
                  ? null
                  : IconButton(
                      onPressed: _unselectSystemFilter,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectMyFilter,
              prefixIcon: Icons.favorite_outline,
              text: _optionsProvider.myFilter == null
                  ? Text(
                      "Moje wyszukiwania",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.myFilter!.filterName,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.myFilter == null
                  ? null
                  : IconButton(
                      onPressed: _unselectMyFilter,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
