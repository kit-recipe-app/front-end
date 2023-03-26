import 'package:flutter/material.dart';

import '../../../shared/input_field.dart';

///Dialog for changing password
class PasswordDialog extends StatefulWidget {
  ///Title of the dialog
  final String title;
  ///Function to set new password
  final Function setPassword;

  const PasswordDialog(
      {Key? key,
        required this.title,
        required this.setPassword})
      : super(key: key);

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final TextEditingController _controllerOld = TextEditingController();
  final TextEditingController _controllerNew = TextEditingController();
  final TextEditingController _controllerNewRepeat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        height: 220,
        child: Column(
          children: [
            RAInputField(
              hintText: "altes Passwort",
              controller: _controllerOld,
              isPassword: true,
              icon: Icons.key,
            ),
            RAInputField(
              hintText: "neues Passwort",
              controller: _controllerNew,
              isPassword: true,
              icon: Icons.key,
            ),
            RAInputField(
              hintText: "wiederholen",
              controller: _controllerNewRepeat,
              isPassword: true,
              icon: Icons.key,
            ),
          ],
        ),
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
            if (_controllerNewRepeat.text == _controllerNew.text) {
              setState(() {
                widget.setPassword(_controllerOld.text, _controllerNew.text);
              });
              Navigator.pop(context);
            }else{
              setState(() {
              });
            }
          },
        ),
      ],
    );
  }
}
