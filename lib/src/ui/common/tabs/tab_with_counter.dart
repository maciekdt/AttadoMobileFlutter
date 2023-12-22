import 'package:attado_mobile/src/models/data_models/common/item_type.dart';
import 'package:attado_mobile/src/ui/common/badges/counter_badge.dart';
import 'package:attado_mobile/src/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TabWithCounter extends StatelessWidget {
  const TabWithCounter({
    super.key,
    this.label,
    this.value,
    this.background,
    this.icon,
    this.showOnZero = true,
    this.itemType = ItemType.document,
  });
  final String? label;
  final int? value;
  final Color? background;
  final bool showOnZero;
  final IconData? icon;
  final ItemType itemType;

  Color _getCounterColor(BuildContext context) {
    if (itemType == ItemType.document) {
      return Theme.of(context).brightness == Brightness.light
          ? AppColors.documentConLight
          : AppColors.documentConDark;
    }
    if (itemType == ItemType.folder) {
      return Theme.of(context).brightness == Brightness.light
          ? AppColors.folderConLight
          : AppColors.folderConDark;
    }
    if (itemType == ItemType.contact) {
      return Theme.of(context).brightness == Brightness.light
          ? AppColors.contactConLight
          : AppColors.contactConDark;
    }
    if (itemType == ItemType.task) {
      return Theme.of(context).brightness == Brightness.light
          ? AppColors.taskConLight
          : AppColors.taskConDark;
    }
    return Theme.of(context).colorScheme.primaryContainer;
  }

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          label != null
              ? Text(label!)
              : icon != null
                  ? Icon(icon)
                  : const SizedBox(),
          !showOnZero && value != null && value == 0
              ? const SizedBox()
              : Padding(
                  padding: label != null
                      ? const EdgeInsets.only(bottom: 12, left: 3)
                      : const EdgeInsets.only(bottom: 24, left: 0),
                  child: CounterBadge(
                    value: value,
                    background: _getCounterColor(context),
                  ),
                ),
        ],
      ),
    );
  }
}
