import 'package:attado_mobile/src/models/data_models/contacts/contact_type.dart';
import 'package:attado_mobile/src/models/data_models/users/user.dart';
import 'package:attado_mobile/src/ui/common/containers/select_field_container.dart';
import 'package:attado_mobile/src/ui/pages/contacts/providers/contacts_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ContactsStandardFilteringForm extends StatefulWidget {
  const ContactsStandardFilteringForm({super.key});

  @override
  State<StatefulWidget> createState() => _ContactsStandardFilteringFormState();
}

class _ContactsStandardFilteringFormState
    extends State<ContactsStandardFilteringForm> {
  late ContactsOptionsProvider _optionsProvider;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  @override
  void initState() {
    final tempOptionsProvider =
        Provider.of<ContactsOptionsProvider>(context, listen: false);
    if (tempOptionsProvider.options.name != null) {
      _controllerName.text = tempOptionsProvider.options.name!;
    }
    if (tempOptionsProvider.options.email != null) {
      _controllerEmail.text = tempOptionsProvider.options.email!;
    }
    if (tempOptionsProvider.options.contactId != null) {
      _controllerId.text = tempOptionsProvider.options.contactId!;
    }
    if (tempOptionsProvider.options.address != null) {
      _controllerAddress.text = tempOptionsProvider.options.address!;
    }
    if (tempOptionsProvider.options.phone != null) {
      _controllerPhone.text = tempOptionsProvider.options.phone!;
    }
    if (tempOptionsProvider.options.description != null) {
      _controllerDescription.text = tempOptionsProvider.options.description!;
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

  void _onEmailChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setEmail(text);
    }
  }

  void _onEmailCancel() {
    _optionsProvider.setEmail(null);
    _controllerEmail.clear();
  }

  void _onIdChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setId(text);
    }
  }

  void _onIdCancel() {
    _optionsProvider.setId(null);
    _controllerId.clear();
  }

  void _onAddressChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setAddress(text);
    }
  }

  void _onAddressCancel() {
    _optionsProvider.setAddress(null);
    _controllerAddress.clear();
  }

  void _onPhoneChanged(String text) {
    if (text.isNotEmpty) {
      _optionsProvider.setPhone(text);
    }
  }

  void _onPhoneCancel() {
    _optionsProvider.setPhone(null);
    _controllerPhone.clear();
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

  void _unselectResponsibleUser() {
    _optionsProvider.responsibleUser = null;
  }

  void _selectType() async {
    var result = await context.push("/contacts/filter/type");
    if (result != null) {
      _optionsProvider.contactType = result as ContactType;
    }
  }

  void _unselectType() {
    _optionsProvider.contactType = null;
  }

  @override
  Widget build(BuildContext context) {
    _optionsProvider =
        Provider.of<ContactsOptionsProvider>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 4),
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
              controller: _controllerEmail,
              keyboardType: TextInputType.name,
              onChanged: _onEmailChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.alternate_email_outlined),
                border: const OutlineInputBorder(),
                hintText: "Email",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.email != null
                    ? IconButton(
                        onPressed: _onEmailCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerId,
              keyboardType: TextInputType.name,
              onChanged: _onIdChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.tag),
                border: const OutlineInputBorder(),
                hintText: "Id",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.contactId != null
                    ? IconButton(
                        onPressed: _onIdCancel,
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
              prefixIcon: Icons.contact_page_outlined,
              text: _optionsProvider.contactType == null
                  ? Text(
                      "Rodzaj",
                      style: Theme.of(context).inputDecorationTheme.hintStyle,
                    )
                  : Text(
                      _optionsProvider.contactType!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              sufix: _optionsProvider.contactType == null
                  ? null
                  : IconButton(
                      onPressed: _unselectType,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerAddress,
              keyboardType: TextInputType.name,
              onChanged: _onAddressChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.map_outlined),
                border: const OutlineInputBorder(),
                hintText: "Adres",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.address != null
                    ? IconButton(
                        onPressed: _onAddressCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6.5),
            child: TextFormField(
              controller: _controllerPhone,
              keyboardType: TextInputType.number,
              onChanged: _onPhoneChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone_outlined),
                border: const OutlineInputBorder(),
                hintText: "Telefon",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _optionsProvider.options.phone != null
                    ? IconButton(
                        onPressed: _onPhoneCancel,
                        icon: const Icon(Icons.close),
                      )
                    : null,
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
              keyboardType: TextInputType.text,
              onChanged: _onDescriptionChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.info_outlined),
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
        ],
      ),
    );
  }
}
