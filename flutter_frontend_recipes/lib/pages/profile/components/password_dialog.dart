import 'package:flutter/material.dart';

class PasswordDialog extends StatefulWidget {
  final String title;
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
        height: 200,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 170,
              child: TextField(
                controller: _controllerOld,
                decoration: const InputDecoration(
                  labelText: "altes Passwort"
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 170,
              child: TextField(
                controller: _controllerNew,
                decoration: const InputDecoration(
                    labelText: "neues Passwort"
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 170,
              child: TextField(
                controller: _controllerNewRepeat,
                decoration: const InputDecoration(
                    labelText: "neues Passwort wiederholen"
                ),
              ),
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
