import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/choice_dialog.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_dialog.dart';

import '../../../authentification/auth.dart';
import '../../../shared/input_field.dart';
import '../../../shared/shared_prefs.dart';

class TextTile extends StatefulWidget {
  final String text;
  String info;
  final String type;

  TextTile(
      {Key? key, required this.text, required this.info, required this.type})
      : super(key: key);

  @override
  State<TextTile> createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> {
  final TextEditingController _controller = TextEditingController();
  final List<String> languages = ["Deutsch", "Englisch"];
  final List<String> countries = ["Deutschland", "Österreich", "Schweiz"];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: () async {
          if (widget.type == "text") {
            _dialogBuilder(context, _controller, widget.text);
          } else if (widget.type == "language") {
            _choiceDialogBuilder(context, widget.text, languages);
          } else if (widget.type == "country") {
            _choiceDialogBuilder(context, widget.text, countries);
          } else if (widget.type == "email") {
          } else if (widget.type == "account") {
            bool value = await _showConfirmDialog("Account") ?? false;
            if (value == true) {
              _showDeletionDialog();
            }
          }else if (widget.type == "data") {
            bool value = await _showConfirmDialog("Daten") ?? false;
            if (value == true) {
              SharedPrefs().clear();
            }
          }
        },
        child: Container(
          padding: EdgeInsets.all(8),
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text),
              Text(widget.info,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, TextEditingController controller, String title) {
    controller.text = widget.info;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return TextDialog(
            controller: controller,
            title: title,
            setText: setText,
          );
        });
  }

  Future<dynamic> _showConfirmDialog(String type) {
    String word = type == "Account" ? "Ihren": "Ihre";
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("${type}löschen"),
            content: Text("Möchten Sie $word $type wirklich löschen?"),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  Future<void> _showDeletionDialog(){
    TextEditingController _controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Account löschen"),
            content: SizedBox(
              height: 110,
              child: Column(
                children: [
                  Text("Bitte geben Sie Ihr Passwort ein"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: RAInputField(
                      hintText: "Passwort",
                      controller: _controller,
                      isPassword: true,
                      icon: Icons.key,
                    ),
                  ), // shared type
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                    Navigator.pop(context);
                    RAAuthService().deleteAccount(_controller.text);
                },
              )
            ],
          );
        });
  }

  deleteAccount(String password){
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: password);

    user.reauthenticateWithCredential(cred).then((value) {
      user.delete().then((_) {
        return "Erfolgreich";
      }).catchError((error) {
        return "Löschen fehlgeschlagen";
      });
    }).catchError((err) {
    });
    return "Passwort ungültig";
  }

  Future<void> _choiceDialogBuilder(
      BuildContext context, String title, List<String> values) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ChoiceDialog(
              title: title,
              values: values,
              standard: widget.info,
              setText: setText);
        });
  }

  void setText(String text) {
    setState(() {
      widget.info = text;
    });
  }
}
