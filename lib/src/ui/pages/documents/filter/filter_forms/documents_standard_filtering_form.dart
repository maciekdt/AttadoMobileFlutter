import 'package:attado_mobile/src/models/data_models/documents/document_state.dart';
import 'package:attado_mobile/src/models/data_models/documents/document_type.dart';
import 'package:attado_mobile/src/models/data_models/documents/file_type.dart';
import 'package:attado_mobile/src/models/data_models/users/user.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/containers/select_field_container.dart';
import 'package:attado_mobile/src/ui/pages/documents/providers/documents_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DocumentsStandardFilteringForm extends StatefulWidget {
  const DocumentsStandardFilteringForm({
    super.key,
    required this.documentsService,
  });

  final DocumentsService documentsService;

  @override
  State<StatefulWidget> createState() => _DocumentsStandardFilteringFormState();
}

class _DocumentsStandardFilteringFormState
    extends State<DocumentsStandardFilteringForm> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDocumentNumber =
      TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  bool _documentNameFilterSelected = false;
  bool _documentNumberFilterSelected = false;
  bool _descriptionFilterSelected = false;
  bool _onlyLast = false;
  late DocumentsOptionsProvider _optionsProvider;

  @override
  void initState() {
    final tempOptionsProvider =
        Provider.of<DocumentsOptionsProvider>(context, listen: false);
    if (tempOptionsProvider.options.documentNumber != null) {
      _controllerDocumentNumber.text =
          tempOptionsProvider.options.documentNumber!;
      _documentNumberFilterSelected = true;
    } else {
      _documentNumberFilterSelected = false;
    }
    if (tempOptionsProvider.options.name != null) {
      _controllerName.text = tempOptionsProvider.options.name!;
      _documentNameFilterSelected = true;
    } else {
      _documentNameFilterSelected = false;
    }
    if (tempOptionsProvider.options.description != null) {
      _controllerDescription.text = tempOptionsProvider.options.description!;
      _descriptionFilterSelected = true;
    } else {
      _descriptionFilterSelected = false;
    }
    _onlyLast = tempOptionsProvider.options.onlyLast;
    super.initState();
  }

  void _onDocumentNameChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setName(text);
      setState(() {
        _documentNameFilterSelected = true;
      });
    }
  }

  void _onDocumentNameCancel() {
    _optionsProvider.setName(null);
    _controllerName.clear();
    setState(() {
      _documentNameFilterSelected = false;
    });
  }

  void _onDocumentNumberChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setDocumentNumber(text);
      setState(() {
        _documentNumberFilterSelected = true;
      });
    }
  }

  void _onDocumentNumberCancel() {
    _optionsProvider.setDocumentNumber(null);
    _controllerDocumentNumber.clear();
    setState(() {
      _documentNumberFilterSelected = false;
    });
  }

  void _onDescriptionChanged(String text) {
    _optionsProvider.setDescription(text);
    if (text.isNotEmpty) {
      setState(() {
        _descriptionFilterSelected = true;
      });
    }
  }

  void _onDescriptionCancel() {
    _optionsProvider.setDescription(null);
    _controllerDescription.clear();
    setState(() {
      _descriptionFilterSelected = false;
    });
  }

  void _onOnlyLastChanged(bool? value) {
    _optionsProvider.setOnlyLast(value!);
    setState(() {
      _onlyLast = value;
    });
  }

  void _selectUser() async {
    var result = await context.push("/search/user");
    if (result != null) {
      _optionsProvider.user = result as User;
    }
  }

  void _unselectUser() {
    _optionsProvider.user = null;
  }

  void _selectDocumentType() async {
    var result = await context.push("/documents/filter/document-type");
    if (result != null) {
      _optionsProvider.documentType = result as DocumentType;
    }
  }

  void _unselectDocumentType() {
    _optionsProvider.documentType = null;
    _optionsProvider.state = null;
  }

  void _selectFileType() async {
    var result = await context.push("/documents/filter/file-type");
    if (result != null) {
      _optionsProvider.fileType = result as FileType;
    }
  }

  void _selectDocumentState() async {
    if (_optionsProvider.documentType != null) {
      var result = await context
          .push("/documents/filter/state/${_optionsProvider.documentType!.id}");
      if (result != null) {
        _optionsProvider.state = result as DocumentState;
      }
    }
  }

  void _unselectDocumentState() {
    _optionsProvider.state = null;
  }

  void _unselectFileType() {
    _optionsProvider.fileType = null;
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
            child: TextFormField(
              controller: _controllerName,
              keyboardType: TextInputType.name,
              onChanged: _onDocumentNameChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.badge_outlined),
                border: const OutlineInputBorder(),
                hintText: "Nazwa",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _documentNameFilterSelected
                    ? IconButton(
                        onPressed: _onDocumentNameCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerDocumentNumber,
              keyboardType: TextInputType.name,
              onChanged: _onDocumentNumberChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                prefixIcon: const Icon(Icons.tag),
                border: const OutlineInputBorder(),
                hintText: "Numer systemowy",
                suffixIcon: _documentNumberFilterSelected
                    ? IconButton(
                        onPressed: _onDocumentNumberCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectDocumentType,
              prefixIcon: Icons.description_outlined,
              text: _optionsProvider.documentType == null
                  ? Text(
                      "Rodzaj",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.documentType!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.documentType == null
                  ? null
                  : IconButton(
                      onPressed: _unselectDocumentType,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectDocumentState,
              prefixIcon: Icons.content_paste_search_outlined,
              text: _optionsProvider.state == null
                  ? Text(
                      "Stan",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.state!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.state == null
                  ? null
                  : IconButton(
                      onPressed: _unselectDocumentState,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectFileType,
              prefixIcon: Icons.file_open_outlined,
              text: _optionsProvider.fileType == null
                  ? Text(
                      "Rodzaj pliku",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.fileType!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.fileType == null
                  ? null
                  : IconButton(
                      onPressed: _unselectFileType,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectUser,
              prefixIcon: Icons.person_outline,
              text: _optionsProvider.user == null
                  ? Text(
                      "Opracował",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.getUserText(_optionsProvider.user!),
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.user == null
                  ? null
                  : IconButton(
                      onPressed: _unselectUser,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerDescription,
              keyboardType: TextInputType.name,
              onChanged: _onDescriptionChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.info_outline),
                border: const OutlineInputBorder(),
                hintText: "Info",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _descriptionFilterSelected
                    ? IconButton(
                        onPressed: _onDescriptionCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              prefixIcon: Icons.published_with_changes,
              text: Text(
                "Tylko najnowsze wersje",
                style: Theme.of(context).inputDecorationTheme.hintStyle,
              ),
              sufix: Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: _onlyLast,
                  onChanged: _onOnlyLastChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
