import 'package:attado_mobile/src/ui/common/containers/text_with_label.dart';
import 'package:flutter/material.dart';

class ClickableTextWithLabel extends StatelessWidget {
  const ClickableTextWithLabel({
    super.key,
    required this.label,
    required this.text,
    required this.onTap,
    this.sufix = const Icon(
      Icons.chevron_right,
      size: 32,
    ),
    this.subText,
  });

  final String label;
  final String text;
  final void Function() onTap;
  final Widget? sufix;
  final String? subText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWithLabel(
            label: label,
            text: text,
            subText: subText,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: sufix,
          )
        ],
      ),
    );
  }
}
