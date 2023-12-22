import 'package:flutter/material.dart';

class RoundedTextLabel extends StatelessWidget {
  const RoundedTextLabel({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.maxWidth = 150,
    this.maxLines = 1,
    this.icon,
    this.fontSize = 11,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 7,
      vertical: 4.3,
    ),
  });

  final String text;
  final Color backgroundColor;
  final IconData? icon;
  final double maxWidth;
  final int maxLines;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Icon(icon, color: Colors.white, size: 13),
                )
              : const SizedBox(),
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Text(
              text,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
