import 'package:flutter/material.dart';

class TextWithLabel extends StatelessWidget {
  const TextWithLabel({
    super.key,
    required this.label,
    required this.text,
    this.subText,
    this.maxWidth = 300,
  });

  final String label;
  final String text;
  final String? subText;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          ),
          subText != null ? const SizedBox(height: 6) : const SizedBox(),
          subText != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Text(
                        subText!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
