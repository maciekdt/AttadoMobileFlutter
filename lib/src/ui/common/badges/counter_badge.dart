import 'package:flutter/material.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge({
    super.key,
    required this.value,
    this.background,
    this.maxValue = 99,
  });
  final int? value;
  final Color? background;
  final int? maxValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background ?? Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5.5, vertical: 2.5),
      child: value == null
          ? Text(
              '?',
              style: Theme.of(context).textTheme.headlineSmall,
            )
          : maxValue == null || value! < maxValue!
              ? Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              : Text(
                  '${maxValue!}+',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
    );
  }
}
