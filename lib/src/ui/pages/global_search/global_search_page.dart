import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/common/related_item.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/ui/common/containers/clickable_search_box.dart';
import 'package:attado_mobile/src/ui/common/list_items/related_object_item.dart';
import 'package:attado_mobile/src/ui/common/navigations/settings_navigation_drawer.dart';
import 'package:flutter/material.dart';

class GlobalSearchPage extends StatefulWidget {
  GlobalSearchPage({super.key});

  final AuthRepo authRepo = getIt<AuthRepo>();
  final DocumentsService service = getIt<DocumentsService>();

  @override
  State<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  bool _search = false;
  List<RelatedItem>? _items = null;

  void _swipeSearch() {
    setState(() {
      _search = !_search;
    });
  }

  void onChangedQuery(String? query) {
    if (query != null) {
      setState(() {
        _items = null;
      });
      widget.service.getGlobalSearch(query).then((items) {
        setState(() {
          _items = items;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_search
          ? AppBar(
              title: const Image(
                image: AssetImage('assets/logo.png'),
                height: 40,
              ),
              centerTitle: true,
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
                  onChanged: onChangedQuery,
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
      drawer: SettingsNavigationDrawer(authRepo: widget.authRepo),
      body: !_search
          ? Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ClickableSearchBox(onTap: _swipeSearch),
                ),
                const Expanded(
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      height: 70,
                    ),
                  ),
                ),
              ],
            )
          : _items == null
              ? const Center(child: CircularProgressIndicator())
              : _items!.isEmpty
                  ? Center(
                      child: Text(
                        "Brak elementów",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _items!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RelatedObjectItem(
                          item: _items![index],
                        );
                      },
                    ),
    );
  }
}
