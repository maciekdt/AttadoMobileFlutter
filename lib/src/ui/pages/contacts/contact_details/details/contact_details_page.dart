import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/ui/common/containers/clickable_text_with_label.dart';
import 'package:attado_mobile/src/ui/common/containers/text_with_label.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  Future<void> _launchPhone() async {
    if (widget.contact.phone != null) {
      String formatedNumber = widget.contact.phone!.replaceAll(' ', '-');
      Uri phoneNumberUri = Uri.parse("tel:$formatedNumber");
      await launchUrl(phoneNumberUri);
    }
  }

  Future<void> _launchMobilePhone() async {
    if (widget.contact.mobilePhone != null) {
      String formatedNumber = widget.contact.mobilePhone!.replaceAll(' ', '-');
      Uri phoneNumberUri = Uri.parse("tel:$formatedNumber");
      await launchUrl(phoneNumberUri);
    }
  }

  Future<void> _launchWebsite() async {
    if (widget.contact.webSite != null) {
      await launchUrl(Uri.parse("${widget.contact.webSite}"));
    }
  }

  Future<void> _launchEmail() async {
    if (widget.contact.email != null) {
      await launchUrl(Uri.parse("mailto:${widget.contact.email}"));
    }
  }

  Future<void> _launchMap() async {
    if (widget.contact.address != null) {
      await MapsLauncher.launchQuery(widget.contact.address!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextWithLabel(
            label: "Nazwa",
            text: widget.contact.fullName,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Rodzaj",
            text: widget.contact.kindName,
          ),
          const DetailsDivider(),
          widget.contact.phone != null
              ? Column(
                  children: [
                    ClickableTextWithLabel(
                      label: "Telefon",
                      text: widget.contact.phone!,
                      onTap: _launchPhone,
                      sufix: const Icon(Icons.call_outlined),
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.contact.mobilePhone != null
              ? Column(
                  children: [
                    ClickableTextWithLabel(
                      label: "Telefon komórkowy",
                      text: widget.contact.mobilePhone!,
                      onTap: _launchMobilePhone,
                      sufix: const Icon(Icons.call_outlined),
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.contact.email != null
              ? Column(
                  children: [
                    ClickableTextWithLabel(
                      label: "E-mail",
                      text: widget.contact.email!,
                      onTap: _launchEmail,
                      sufix: const Icon(Icons.send_outlined),
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          TextWithLabel(
            label: "Odpowiedzialny",
            text:
                '${widget.contact.responsibleUserFirstName} ${widget.contact.responsibleUserSurname}',
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Opracował",
            text:
                '${widget.contact.createUserFirstName} ${widget.contact.createUserSurname}',
            subText: DateFormat('dd.MM.yyyy HH:mm')
                .format(widget.contact.createDate),
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Zmodyfikował",
            text:
                '${widget.contact.updateUserFirstName} ${widget.contact.updateUserSurname}',
            subText: DateFormat('dd.MM.yyyy HH:mm')
                .format(widget.contact.updateDate),
          ),
          const DetailsDivider(),
          widget.contact.address != null
              ? Column(
                  children: [
                    ClickableTextWithLabel(
                      label: "Adres",
                      text: widget.contact.address!,
                      subText: widget.contact.postalAddress,
                      onTap: _launchMap,
                      sufix: const Icon(Icons.map_outlined),
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.contact.taxNumber != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "NIP",
                      text: widget.contact.taxNumber!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.contact.regonPesel != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "REGON/PESEL",
                      text: widget.contact.regonPesel!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.contact.webSite != null
              ? Column(
                  children: [
                    ClickableTextWithLabel(
                      label: "Strona www",
                      text: widget.contact.webSite!,
                      onTap: _launchWebsite,
                      sufix: const Icon(Icons.link_outlined),
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.contact.description != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Info",
                      text: widget.contact.description!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
