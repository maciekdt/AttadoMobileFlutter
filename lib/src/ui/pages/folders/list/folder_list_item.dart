import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/ui/common/containers/rounded_text_label.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FolderListItem extends StatefulWidget {
  const FolderListItem({
    super.key,
    required this.folder,
    this.isMainList = true,
  });
  final Folder folder;
  final bool isMainList;

  @override
  State<FolderListItem> createState() => _FolderListItemState();
}

class _FolderListItemState extends State<FolderListItem> {
  void _onTap() async {
    await context.push("/folders/details", extra: widget.folder);
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
              vertical: 16,
              horizontal: 16,
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      size: 37,
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.folderLight
                          : AppColors.folderDark,
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
                          widget.folder.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.folder.folderNumber,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.folder.typeName,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 13),
                        ),
                        const SizedBox(height: 3),
                        SizedBox(
                          //width: 100,
                          child: RoundedTextLabel(
                            text: widget.folder.statusName,
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.folderConLight
                                    : AppColors.folderConDark,
                            icon: Icons.content_paste_search_outlined,
                            maxWidth: 200,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        RoundedTextLabel(
                          text:
                              '${widget.folder.responsibleUserFirstName} ${widget.folder.responsibleUserSurname}',
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.contactConLight
                                  : AppColors.contactConDark,
                          icon: Icons.person_outline,
                        ),
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
