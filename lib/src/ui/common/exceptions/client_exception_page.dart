import 'package:flutter/material.dart';

class ClientExceptionPage extends StatelessWidget {
  const ClientExceptionPage({
    super.key,
    required this.onRefresh,
  });

  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Wystąpił błąd",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: onRefresh,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh_outlined),
              SizedBox(width: 3),
              Text(
                "Spróbuj ponownie",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
