import 'package:flutter/material.dart';

class TextDialog extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final Function setText;

  const TextDialog(
      {Key? key,
      required this.controller,
      required this.title,
      required this.setText})
      : super(key: key);

  @override
  State<TextDialog> createState() => _TextDialogState();
}

class _TextDialogState extends State<TextDialog> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 170,
            child: TextField(
              controller: widget.controller,
            ),
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _visible,
            child: Tooltip(child: Icon(Icons.error), message: "empty not allowed", triggerMode: TooltipTriggerMode.tap,),
          )
        ],
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
            if (widget.controller.text.isNotEmpty) {
              setState(() {
                _visible = false;
                widget.setText(widget.controller.text);
              });
              Navigator.pop(context);
            }else{
              setState(() {
                FocusManager.instance.primaryFocus?.unfocus();
                _visible = true;
              });
            }
          },
        ),
      ],
    );
  }
}
