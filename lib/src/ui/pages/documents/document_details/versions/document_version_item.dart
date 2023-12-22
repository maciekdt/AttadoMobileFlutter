import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentVersionItem extends StatefulWidget {
  const DocumentVersionItem({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  State<DocumentVersionItem> createState() => _DocumentVersionItemState();
}

class _DocumentVersionItemState extends State<DocumentVersionItem> {
  void _goToDetails() async {
    await context.push("/documents/details", extra: widget.document);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _goToDetails,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  maxRadius: 17,
                  backgroundColor: widget.document.isLast
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.error,
                  child: Text(
                    'v${widget.document.versionNumber}',
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    width: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.document.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        widget.document.fileName != null
                            ? Column(
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.document.fileName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(height: 1.5),
                                ],
                              )
                            : const SizedBox(),
                        widget.document.versionDescription != null
                            ? Column(
                                children: [
                                  const SizedBox(height: 3),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.info_outline, size: 15),
                                      const SizedBox(width: 2),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 1.3),
                                        child: SizedBox(
                                          width: 220,
                                          child: Text(
                                              widget
                                                  .document.versionDescription!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, size: 32),
          ],
        ),
      ),
    );
  }
}
