import 'dart:async';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/pages/contacts/contact_details/contact_details_provider.dart';
import 'package:attado_mobile/src/ui/common/list_items/history_action_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactHistoryPage extends StatefulWidget {
  const ContactHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _ContactHistoryPageState();
}

class _ContactHistoryPageState extends State<ContactHistoryPage>
    with AutomaticKeepAliveClientMixin<ContactHistoryPage> {
  late ContactDetailsProvider _provider;

  Future<void> _refresh() async {
    await _provider.loadHistory();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ContactDetailsProvider>(context);

    super.build(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: _provider.history == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _provider.history!.isEmpty
              ? Center(
                  child: Text(
                    "Brak elementów",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: _provider.history!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        index == 0
                            ? const Column(
                                children: [
                                  SizedBox(height: 1),
                                  DetailsDivider(),
                                ],
                              )
                            : const SizedBox(),
                        HistoryActionItem(action: _provider.history![index]),
                        const DetailsDivider(),
                      ],
                    );
                  },
                ),
    );
  }
}
