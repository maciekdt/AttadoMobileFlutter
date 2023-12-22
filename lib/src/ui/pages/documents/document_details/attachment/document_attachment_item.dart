import 'package:attado_mobile/src/models/data_models/documents/document_attachment_file.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocumentAttachmentItem extends StatelessWidget {
  const DocumentAttachmentItem({
    super.key,
    required this.file,
    required this.downloadAndOpenFile,
  });

  final DocumentAttachmentFile file;
  final Future<void> Function(DocumentAttachmentFile file) downloadAndOpenFile;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => downloadAndOpenFile(file),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          width: 350,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        file.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        file.fileName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 13),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined, size: 15),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.3),
                            child: Text(
                                DateFormat('dd.MM.yyyy HH:mm')
                                    .format(file.fileUpdateDate),
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 15),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.3),
                            child: Text(
                                file.fileUpdateUserFirstName == null ||
                                        file.fileUpdateUserSurname == null
                                    ? file.fileUpdateUserName
                                    : '${file.fileUpdateUserFirstName!} ${file.fileUpdateUserSurname!}',
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.download),
            ],
          ),
        ),
      ),
    );
  }
}
