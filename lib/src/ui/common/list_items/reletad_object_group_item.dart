import 'package:flutter/material.dart';

class RelatedObjectGroupItem extends StatelessWidget {
  const RelatedObjectGroupItem({
    super.key,
    required this.title,
    required this.icon,
    required this.relatedNumber,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final int relatedNumber;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: relatedNumber == 0 ? () {} : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        //width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 16.5),
                ),
              ],
            ),
            CircleAvatar(
              maxRadius: 16,
              backgroundColor: relatedNumber > 0
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.outline,
              child: Text(
                relatedNumber.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
