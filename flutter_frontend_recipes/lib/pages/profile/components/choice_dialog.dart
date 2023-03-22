import 'package:flutter/material.dart';

class ChoiceDialog extends StatefulWidget {
  final String title;
  final String standard;
  final List<String> values;
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
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
