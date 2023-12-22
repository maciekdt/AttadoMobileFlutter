import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({
    super.key,
    required this.filtersCount,
    required this.onTap,
  });

  final int filtersCount;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: badges.Badge(
        showBadge: filtersCount != 0,
        badgeContent: Text(
          filtersCount.toString(),
          style: const TextStyle(fontSize: 11, color: Colors.white),
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: Theme.of(context).colorScheme.tertiary,
        ),
        position: badges.BadgePosition.topEnd(top: 6, end: 2.5),
        child: Padding(
          padding: const EdgeInsets.only(top: 3.2),
          child: IconButton(
            icon: const Icon(
              Icons.filter_list,
              size: 26,
            ),
            tooltip: 'Flitrowanie',
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
