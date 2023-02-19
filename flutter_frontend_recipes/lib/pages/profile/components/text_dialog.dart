import 'package:flutter/material.dart';

class TextDialog extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Function setText;
  const TextDialog({Key? key, required this.controller, required this.title, required this.setText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            setText(controller.text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
