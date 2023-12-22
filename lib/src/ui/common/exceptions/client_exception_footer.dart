import 'package:flutter/material.dart';

class ClientExceptionFooter extends StatelessWidget {
  const ClientExceptionFooter({
    super.key,
    required this.onRefresh,
  });

  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextButton(
        onPressed: onRefresh,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.refresh_outlined),
            SizedBox(width: 3),
            Text(
              "Wystąpił błąd",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
