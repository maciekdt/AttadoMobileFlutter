import 'package:flutter/material.dart';

class ClickableSearchBox extends StatelessWidget {
  const ClickableSearchBox({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.search, size: 28),
              const SizedBox(width: 5),
              Text(
                "Szukaj...",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
