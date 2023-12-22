import 'package:flutter/material.dart';

class BottomNavigationFilter extends StatelessWidget {
  const BottomNavigationFilter({
    super.key,
    required this.onClear,
    required this.onSubmit,
  });

  final void Function() onClear;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: Theme.of(context).colorScheme.outline,
            ),
            onPressed: onClear,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 0, right: 10),
              child: SizedBox(
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      color: Theme.of(context).textTheme.headlineSmall?.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Wyczyść",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onPressed: onSubmit,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, right: 3),
              child: SizedBox(
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.filter_alt_outlined,
                      color: Theme.of(context).textTheme.headlineSmall?.color,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "Zastosuj",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
