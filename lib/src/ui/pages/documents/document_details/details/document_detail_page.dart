import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/ui/common/containers/clickable_text_with_label.dart';
import 'package:attado_mobile/src/ui/common/containers/text_with_label.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocumentDetailPage extends StatefulWidget {
  const DocumentDetailPage({
    super.key,
    required this.document,
    required this.downloadAndOpenFile,
  });

  final Document document;
  final Future<void> Function() downloadAndOpenFile;

  @override
  State<DocumentDetailPage> createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //const SizedBox(height: 10),
          TextWithLabel(
            label: "Nazwa",
            text: widget.document.name,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Nr systemowy",
            text: widget.document.documentNumber,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Wersja",
            text:
                "${widget.document.versionNumber} ${widget.document.isLast ? "aktualna" : "nieaktualna"}",
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Rodzaj",
            text: widget.document.typeName,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Stan",
            text: widget.document.workflowStateName,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Odpowiedzialny",
            text: widget.document.responsibleUserFirstName.isEmpty ||
                    widget.document.responsibleUserSurname.isEmpty
                ? widget.document.responsibleUserName
                : "${widget.document.responsibleUserFirstName} ${widget.document.responsibleUserSurname}",
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Opracował",
            text: widget.document.createUserFirstName.isEmpty ||
                    widget.document.createUserSurname.isEmpty
                ? widget.document.createUserName
                : "${widget.document.createUserFirstName} ${widget.document.createUserSurname}",
            subText: DateFormat('dd.MM.yyyy HH:mm')
                .format(widget.document.createDate),
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Zmodyfikował",
            text: widget.document.updateUserFirstName.isEmpty ||
                    widget.document.updateUserSurname.isEmpty
                ? widget.document.updateUserName
                : "${widget.document.updateUserFirstName} ${widget.document.updateUserSurname}",
            subText: DateFormat('dd.MM.yyyy HH:mm')
                .format(widget.document.createDate),
          ),
          widget.document.signature != null
              ? Column(
                  children: [
                    const DetailsDivider(),
                    TextWithLabel(
                      label: "Sygnatura",
                      text: widget.document.signature!,
                    ),
                  ],
                )
              : const SizedBox(),
          widget.document.extNumber != null
              ? Column(
                  children: [
                    const DetailsDivider(),
                    TextWithLabel(
                      label: "Nr zewnętrzy",
                      text: widget.document.extNumber!,
                    ),
                  ],
                )
              : const SizedBox(),
          const DetailsDivider(),
          ClickableTextWithLabel(
            label: "Plik",
            text: widget.document.fileName != null
                ? widget.document.fileName as String
                : "Brak pliku",
            sufix: widget.document.fileName != null
                ? const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(Icons.download),
                  )
                : const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(Icons.file_download_off),
                  ),
            onTap: widget.downloadAndOpenFile,
          ),
          widget.document.fileUpdateDate != null
              ? Column(
                  children: [
                    const DetailsDivider(),
                    TextWithLabel(
                      label: "Ost. mod. pliku",
                      text: DateFormat('dd.MM.yyyy HH:mm')
                          .format(widget.document.fileUpdateDate!),
                    ),
                  ],
                )
              : const SizedBox(),
          widget.document.description != null
              ? Column(
                  children: [
                    const DetailsDivider(),
                    TextWithLabel(
                      label: "Info",
                      text: widget.document.description!,
                    ),
                  ],
                )
              : const SizedBox(),
          widget.document.storage != null
              ? Column(
                  children: [
                    const DetailsDivider(),
                    TextWithLabel(
                      label: "Miejsce przechowywania",
                      text: widget.document.storage!,
                    ),
                  ],
                )
              : const SizedBox(),
          widget.document.validTo != null
              ? Column(
                  children: [
                    const DetailsDivider(),
                    TextWithLabel(
                      label: "Data ważności",
                      text: DateFormat('dd.MM.yyyy')
                          .format(widget.document.validTo!),
                    ),
                  ],
                )
              : const SizedBox(),
          const DetailsDivider(),
        ],
      ),
    );
  }
}
