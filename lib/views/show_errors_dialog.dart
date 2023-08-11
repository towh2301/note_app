import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String details,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text(details),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
