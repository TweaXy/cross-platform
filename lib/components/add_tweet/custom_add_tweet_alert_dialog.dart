import 'package:flutter/material.dart';

class CustomAddTweetAlertDialog extends StatelessWidget {
  const CustomAddTweetAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Discard Tweet?'),
      content: const Text('Are you sure you want to discard this tweet?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Yes');
            Navigator.pop(context, 'Yes');
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'NO'),
          child: const Text(
            'No',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
