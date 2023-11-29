import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.height * 0.9;

    return AlertDialog(
      insetPadding: EdgeInsets.all(width * 0.04),
      contentPadding:
          EdgeInsets.only(left: width * 0.035, right: width * 0.035, top: 10),
      title: Text('Delete post?',
          style:
              TextStyle(fontSize: 25)), // To display the title it is optional
      content: Text(
          style: TextStyle(fontSize: 18),
          'This can\'t be undone and it will be removed from your profile, the timeline of any accounts that follow you, and from search results'), // Message which will be pop up on the screen
      actions: [
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel',
              style: TextStyle(color: Colors.black, fontSize: 19)),
        ),
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Delete',
              style: TextStyle(color: Colors.black, fontSize: 19)),
        ),
      ],
    );
  }
}
