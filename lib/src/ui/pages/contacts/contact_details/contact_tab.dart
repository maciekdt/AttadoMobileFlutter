import 'package:attado_mobile/src/models/data_models/common/item_type.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/ui/common/tabs/tab_with_counter.dart';
import 'package:attado_mobile/src/ui/pages/contacts/contact_details/details/contact_details_page.dart';
import 'package:attado_mobile/src/ui/pages/contacts/contact_details/history/contact_history_page.dart';
import 'package:attado_mobile/src/ui/pages/contacts/contact_details/related/contact_related_object_page.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_details_provider.dart';

class ContactTab extends StatefulWidget {
  const ContactTab({
    super.key,
    required this.contact,
  });
  final Contact contact;

  @override
  State<StatefulWidget> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  Future<void> _launchDefaultPhone() async {
    Uri phoneNumberUri;
    if (widget.contact.phone != null) {
      String formatedNumber = widget.contact.phone!.replaceAll(' ', '-');
      phoneNumberUri = Uri.parse("tel:$formatedNumber");
    } else if (widget.contact.mobilePhone != null) {
      String formatedNumber = widget.contact.mobilePhone!.replaceAll(' ', '-');
      phoneNumberUri = Uri.parse("tel:$formatedNumber");
    } else {
      return;
    }
    await launchUrl(phoneNumberUri);
  }

  Future<void> _launchEmail() async {
    if (widget.contact.email != null) {
      await launchUrl(Uri.parse("mailto:${widget.contact.email}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactDetailsProvider(contact: widget.contact),
      child: Consumer<ContactDetailsProvider>(
        builder: (context, provider, child) => DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                leadingWidth: 40,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 3, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.contact.fullName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 14.5),
                      ),
                      widget.contact.email != null
                          ? Column(
                              children: [
                                const SizedBox(height: 2),
                                Text(
                                  widget.contact.email!,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontSize: 12),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                actions: [
                  widget.contact.mobilePhone != null ||
                          widget.contact.phone != null
                      ? IconButton(
                          onPressed: _launchDefaultPhone,
                          icon: const Icon(Icons.call_outlined))
                      : const SizedBox(),
                  widget.contact.email != null
                      ? IconButton(
                          onPressed: _launchEmail,
                          icon: const Icon(Icons.mail_outlined))
                      : const SizedBox(),
                ],
                bottom: TabBar(
                  tabAlignment: TabAlignment.fill,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor:
                      Theme.of(context).brightness == Brightness.light
                          ? AppColors.contactLight
                          : AppColors.contactDark,
                  labelColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.contactLight
                      : AppColors.contactDark,
                  tabs: [
                    const Tab(child: Icon(Icons.person_outlined)),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 7.5),
                      child: TabWithCounter(
                        label: "Powiązane",
                        value: provider.relNumber,
                        itemType: ItemType.contact,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 7.5),
                      child: TabWithCounter(
                        label: "Historia",
                        value: provider.history?.length,
                        itemType: ItemType.contact,
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ContactDetailsPage(contact: widget.contact),
                  ContactRelatedObjectsPage(contact: widget.contact),
                  const ContactHistoryPage(),
                ],
              )),
        ),
      ),
    );
  }
}
