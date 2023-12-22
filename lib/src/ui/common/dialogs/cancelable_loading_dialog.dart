import 'package:flutter/material.dart';

class CancelableLoadingDialog extends StatelessWidget {
  const CancelableLoadingDialog({
    super.key,
    required this.message,
    required this.onCancel,
  });

  final String message;
  final void Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            const CircularProgressIndicator(strokeWidth: 5),
            const SizedBox(height: 20),
            Text(
              message,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 3),
            TextButton(
              onPressed: onCancel,
              child: const Text("Anuluj", style: TextStyle(fontSize: 17)),
            ),
          ],
        ),
      ),
    );
  }
}
