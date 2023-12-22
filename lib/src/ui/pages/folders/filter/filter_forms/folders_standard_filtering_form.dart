import 'package:attado_mobile/src/models/data_models/folders/folder_status.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder_type.dart';
import 'package:attado_mobile/src/models/data_models/users/user.dart';
import 'package:attado_mobile/src/ui/common/containers/select_field_container.dart';
import 'package:attado_mobile/src/ui/pages/folders/providers/folders_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FoldersStandardFilteringForm extends StatefulWidget {
  const FoldersStandardFilteringForm({super.key});

  @override
  State<StatefulWidget> createState() => _FoldersStandardFilteringFormState();
}

class _FoldersStandardFilteringFormState
    extends State<FoldersStandardFilteringForm> {
  late FoldersOptionsProvider _optionsProvider;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerContactName = TextEditingController();

  @override
  void initState() {
    final tempOptionsProvider =
        Provider.of<FoldersOptionsProvider>(context, listen: false);
    if (tempOptionsProvider.options.name != null) {
      _controllerName.text = tempOptionsProvider.options.name!;
    }
    if (tempOptionsProvider.options.folderNumber != null) {
      _controllerNumber.text = tempOptionsProvider.options.folderNumber!;
    }
    if (tempOptionsProvider.options.description != null) {
      _controllerDescription.text = tempOptionsProvider.options.description!;
    }
    if (tempOptionsProvider.options.contactFullName != null) {
      _controllerContactName.text =
          tempOptionsProvider.options.contactFullName!;
    }
    super.initState();
  }

  void _onNameChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setName(text);
    }
  }

  void _onNameCancel() {
    _optionsProvider.setName(null);
    _controllerName.clear();
  }

  void _onNumberChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setFolderNumber(text);
    }
  }

  void _onNumberCancel() {
    _optionsProvider.setFolderNumber(null);
    _controllerNumber.clear();
  }

  void _onDescriptionChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setDescription(text);
    }
  }

  void _onDescriptionCancel() {
    _optionsProvider.setDescription(null);
    _controllerDescription.clear();
  }

  void _onContactNameChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setContactFullName(text);
    }
  }

  void _onContactNameCancel() {
    _optionsProvider.setContactFullName(null);
    _controllerContactName.clear();
  }

  void _selectCreateUser() async {
    var result = await context.push("/search/user");
    if (result != null) {
      _optionsProvider.createUser = result as User;
    }
  }

  void _unselectCreateUser() {
    _optionsProvider.createUser = null;
  }

  void _selectResponsibleUser() async {
    var result = await context.push("/search/user");
    if (result != null) {
      _optionsProvider.responsibleUser = result as User;
    }
  }

  void _unselectType() {
    _optionsProvider.folderType = null;
  }

  void _selectType() async {
    var result = await context.push("/folders/filter/type");
    if (result != null) {
      _optionsProvider.folderType = result as FolderType;
    }
  }

  void _unselectResponsibleUser() {
    _optionsProvider.responsibleUser = null;
  }

  void _selectStatus() async {
    if (_optionsProvider.folderType != null) {
      var result = await context
          .push("/folders/filter/status/${_optionsProvider.folderType!.id}");
      if (result != null) {
        _optionsProvider.folderStatus = result as FolderStatus;
      }
    }
  }

  void _unselectStatus() {
    _optionsProvider.folderStatus = null;
  }

  @override
  Widget build(BuildContext context) {
    _optionsProvider =
        Provider.of<FoldersOptionsProvider>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerName,
              keyboardType: TextInputType.name,
              onChanged: _onNameChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.badge_outlined),
                border: const OutlineInputBorder(),
                hintText: "Nazwa",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.name != null
                    ? IconButton(
                        onPressed: _onNameCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerNumber,
              keyboardType: TextInputType.name,
              onChanged: _onNumberChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.tag),
                border: const OutlineInputBorder(),
                hintText: "Numer systemowy",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.folderNumber != null
                    ? IconButton(
                        onPressed: _onNumberCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectType,
              prefixIcon: Icons.folder_outlined,
              text: _optionsProvider.folderType == null
                  ? Text(
                      "Typ",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.folderType!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.folderType == null
                  ? null
                  : IconButton(
                      onPressed: _unselectType,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectStatus,
              prefixIcon: Icons.content_paste_search_outlined,
              text: _optionsProvider.folderStatus == null
                  ? Text(
                      "Etap",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.folderStatus!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.folderStatus == null
                  ? null
                  : IconButton(
                      onPressed: _unselectStatus,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectCreateUser,
              prefixIcon: Icons.person_outline,
              text: _optionsProvider.createUser == null
                  ? Text(
                      "Opracował",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      '${_optionsProvider.createUser!.firstName} ${_optionsProvider.createUser!.surname}',
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.createUser == null
                  ? null
                  : IconButton(
                      onPressed: _unselectCreateUser,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: SelectFieldContainer(
              onTap: _selectResponsibleUser,
              prefixIcon: Icons.person_outline,
              text: _optionsProvider.responsibleUser == null
                  ? Text(
                      "Odpowiedzialny",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      '${_optionsProvider.responsibleUser!.firstName} ${_optionsProvider.responsibleUser!.surname}',
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.responsibleUser == null
                  ? null
                  : IconButton(
                      onPressed: _unselectResponsibleUser,
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
                suffixIcon: _optionsProvider.options.description != null
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
            child: TextFormField(
              controller: _controllerContactName,
              keyboardType: TextInputType.name,
              onChanged: _onContactNameChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outlined),
                border: const OutlineInputBorder(),
                hintText: "Kontrahent",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.contactFullName != null
                    ? IconButton(
                        onPressed: _onContactNameCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
