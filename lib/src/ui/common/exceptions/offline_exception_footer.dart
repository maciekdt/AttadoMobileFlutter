import 'package:flutter/material.dart';

class OfflineExceptionFooter extends StatelessWidget {
  const OfflineExceptionFooter({
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
              "Brak połączenia z internetem",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
