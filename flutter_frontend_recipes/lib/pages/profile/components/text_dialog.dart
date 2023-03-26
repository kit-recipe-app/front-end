import 'package:flutter/material.dart';

/// A dialog box that allows the user to enter text input.
///
/// This dialog contains a title, a text input field, and two buttons (OK and CANCEL).
/// The user can enter any text input in the text field. If the user attempts to press the OK button without entering any text,
/// the dialog displays an error message.
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
          //error message that is displayed when Textfield is empty
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
        //Cancel Button
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          //Ok Button
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
