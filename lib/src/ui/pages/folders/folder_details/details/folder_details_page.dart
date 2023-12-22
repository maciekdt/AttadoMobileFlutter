import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/ui/common/containers/text_with_label.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FolderDetailsPage extends StatefulWidget {
  const FolderDetailsPage({
    super.key,
    required this.folder,
  });

  final Folder folder;

  @override
  State<FolderDetailsPage> createState() => _FolderDetailsPageState();
}

class _FolderDetailsPageState extends State<FolderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextWithLabel(
            label: "Nazwa",
            text: widget.folder.name,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Nr systemowy",
            text: widget.folder.folderNumber,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Rodzaj",
            text: widget.folder.typeName,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Etap",
            text: widget.folder.statusName,
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Odpowiedzialny",
            text:
                '${widget.folder.responsibleUserFirstName} ${widget.folder.responsibleUserSurname}',
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Opracował",
            text:
                '${widget.folder.createUserFirstName} ${widget.folder.createUserSurname}',
            subText:
                DateFormat('dd.MM.yyyy HH:mm').format(widget.folder.createDate),
          ),
          const DetailsDivider(),
          TextWithLabel(
            label: "Zmodyfikował",
            text:
                '${widget.folder.updateUserFirstName} ${widget.folder.updateUserSurname}',
            subText:
                DateFormat('dd.MM.yyyy HH:mm').format(widget.folder.updateDate),
          ),
          const DetailsDivider(),
          widget.folder.signature != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Sygnatura",
                      text: widget.folder.signature!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.extNumber != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Nr zewnętrzny",
                      text: widget.folder.extNumber!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.startDate != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Data rozpoczęcia",
                      text: DateFormat('dd.MM.yyyy')
                          .format(widget.folder.startDate!),
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.endDate != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Data zakończenia",
                      text: DateFormat('dd.MM.yyyy')
                          .format(widget.folder.endDate!),
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.priorityName != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Priorytet",
                      text: widget.folder.priorityName!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.projectValue != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Wartość projektu",
                      text: widget.folder.projectValue!.toString(),
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.chance != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Szansa",
                      text: '${widget.folder.chance!}%',
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.description != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Info",
                      text: widget.folder.description!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.storage != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Miejsce przechowywania",
                      text: widget.folder.storage!,
                    ),
                    const DetailsDivider(),
                  ],
                )
              : const SizedBox(),
          widget.folder.contactFullName != null
              ? Column(
                  children: [
                    TextWithLabel(
                      label: "Kontrahent",
                      text: widget.folder.contactFullName!,
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
