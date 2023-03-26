import 'package:flutter/material.dart';

/// A dialog that allows the user to choose from a list of options by displaying radio buttons for each option.
class ChoiceDialog extends StatefulWidget {
  ///Title of the Dialog
  final String title;
  ///The default value that should be selected when the dialog is opened.
  final String standard;
  ///Different choices
  final List<String> values;
  ///Called after hitting the "OK" Button
  final Function setText;

  const ChoiceDialog({Key? key, required this.title, required this.values, required this.standard, required this.setText})
      : super(key: key);

  @override
  State<ChoiceDialog> createState() => _ChoiceDialogState();
}

class _ChoiceDialogState extends State<ChoiceDialog> {
  String groupValue = "";

  @override
  void initState() {
    super.initState();
    groupValue = widget.standard;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (String value in widget.values)
            RadioListTile(
              activeColor: Colors.black,
              title: Text(value),
                value: value,
                groupValue: groupValue,
                onChanged: (String? newValue) {
                    setState(() {
                      groupValue = newValue!;
                    });
                })
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
        //Ok Button
        TextButton(
          child: Text('OK'),
          onPressed: () {
            widget.setText(groupValue);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
