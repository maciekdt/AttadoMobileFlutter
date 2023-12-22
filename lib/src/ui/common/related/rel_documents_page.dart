import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/ui/pages/documents/list/documents_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RelDocumentsPage extends StatefulWidget {
  const RelDocumentsPage({
    super.key,
    required this.documents,
    required this.title,
  });

  final List<Document> documents;
  final String title;

  @override
  State<StatefulWidget> createState() => _RelDocumentsPageState();
}

class _RelDocumentsPageState extends State<RelDocumentsPage> {
  List<Document> _filteredDocuments = [];
  bool _search = false;

  @override
  void initState() {
    _filteredDocuments = widget.documents;
    super.initState();
  }

  void _swipeSearch() {
    setState(() {
      _filteredDocuments = widget.documents;
      _search = !_search;
    });
  }

  void _filterList(String? pattern) {
    pattern = pattern?.toLowerCase();
    setState(() {
      _filteredDocuments = widget.documents
          .where((doc) =>
              doc.name.toLowerCase().contains(pattern!) ||
              doc.documentNumber.toLowerCase().contains(pattern) ||
              doc.typeName.toLowerCase().contains(pattern) ||
              ('${doc.createUserFirstName.toLowerCase()} ${doc.createUserSurname.toLowerCase()}')
                  .contains(pattern))
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
                      "Powiązane eDokumenty",
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
      body: _filteredDocuments.isEmpty
          ? Center(
              child: Text(
                "Brak elementów",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          : ListView.builder(
              itemCount: _filteredDocuments.length,
              itemBuilder: (BuildContext context, int index) {
                return DocumentsListItem(
                  document: _filteredDocuments[index],
                  selectable: false,
                  isMainList: false,
                );
              },
            ),
    );
  }
}
