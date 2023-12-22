import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/ui/pages/contacts/list/contact_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RelContactsPage extends StatefulWidget {
  const RelContactsPage({
    super.key,
    required this.contacts,
    required this.title,
  });

  final List<Contact> contacts;
  final String title;

  @override
  State<StatefulWidget> createState() => _RelContactsPageState();
}

class _RelContactsPageState extends State<RelContactsPage> {
  List<Contact> _filteredContacts = [];
  bool _search = false;

  @override
  void initState() {
    _filteredContacts = widget.contacts;
    super.initState();
  }

  void _swipeSearch() {
    setState(() {
      _filteredContacts = widget.contacts;
      _search = !_search;
    });
  }

  void _filterList(String? pattern) {
    pattern = pattern?.toLowerCase();
    setState(() {
      _filteredContacts = widget.contacts
          .where((contact) =>
              contact.fullName.toLowerCase().contains(pattern!) ||
              (contact.email != null &&
                  contact.email!.toLowerCase().contains(pattern)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_search
          ? AppBar(
              leadingWidth: 40,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 3, top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 14.5),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Powiązane eKontakty",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: _swipeSearch,
                  icon: const Icon(Icons.search),
                ),
              ],
            )
          : PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 3.0,
                  right: 10,
                  left: 10,
                  bottom: 5,
                ),
                child: TextFormField(
                  onChanged: _filterList,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 28,
                      ),
                      onPressed: _swipeSearch,
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Szukaj...',
                    focusedBorder: null,
                  ),
                ),
              ),
            ),
      body: _filteredContacts.isEmpty
          ? Center(
              child: Text(
                "Brak elementów",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          : ListView.builder(
              itemCount: _filteredContacts.length,
              itemBuilder: (BuildContext context, int index) {
                return ContactListItem(
                  contact: _filteredContacts[index],
                  isMainList: false,
                );
              },
            ),
    );
  }
}
