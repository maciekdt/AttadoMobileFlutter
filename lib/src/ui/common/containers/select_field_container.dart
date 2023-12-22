import 'package:flutter/material.dart';

class SelectFieldContainer extends StatelessWidget {
  const SelectFieldContainer({
    super.key,
    required this.prefixIcon,
    required this.text,
    this.sufix,
    this.onTap,
  });

  final IconData prefixIcon;
  final Text text;
  final Widget? sufix;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color.fromARGB(255, 95, 93, 93)
                : const Color.fromARGB(140, 116, 116, 116),
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(
                    prefixIcon,
                    color: Theme.of(context).inputDecorationTheme.iconColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(width: 200, height: 20, child: text),
                  ),
                ],
              ),
            ),
            sufix ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
