import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/ui/common/containers/rounded_text_label.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactListItem extends StatefulWidget {
  const ContactListItem({
    super.key,
    required this.contact,
    this.isMainList = true,
  });
  final Contact contact;
  final bool isMainList;

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  void _onTap() async {
    await context.push("/contacts/details", extra: widget.contact);
  }

  IconData _getTypeIcon(Contact contact) {
    if (contact.isPerson) {
      return Icons.person_outlined;
    } else if (contact.isCompany) {
      return Icons.apartment_outlined;
    } else if (contact.isContactGroup) {
      return Icons.groups_outlined;
    } else if (contact.isCompanyAddress) {
      return Icons.location_on_outlined;
    } else if (contact.isCompanyBranch) {
      return Icons.apartment_outlined;
    }
    return Icons.psychology_alt_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
        child: InkWell(
          onTap: _onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 18,
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      _getTypeIcon(widget.contact),
                      size: 37,
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.contactLight
                          : AppColors.contactDark,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 270,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.contact.fullName,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.contact.kindName.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        widget.contact.email != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: SizedBox(
                                  child: RoundedTextLabel(
                                    text: widget.contact.email!,
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppColors.contactConLight
                                            : AppColors.contactConDark,
                                    icon: Icons.email_outlined,
                                    maxWidth: 200,
                                    maxLines: 1,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
