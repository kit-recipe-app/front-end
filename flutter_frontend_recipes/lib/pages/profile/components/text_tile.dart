import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_dialog.dart';

import '../../../authentification/auth.dart';
import '../../../shared/input_field.dart';
import '../../../shared/shared_prefs.dart';

/// A widget that displays a row with a text label and an additional text or dialog with choices
///
/// The widget can be customized by providing a [text] label, [info] text or dialog content, and a [type] to determine
/// the type of interaction when the user taps on the widget. The [type] can be "text" to display a dialog for editing the [info] text,
/// "language" or "country" to display a dialog with a list of choices, "email" or "account" to perform an action without any further
/// interaction, or "data" to display a confirmation dialog before clearing data.
///
/// When the widget is tapped, the [onTap] function is called and the appropriate action is performed depending on the [type] of the widget.
/// If the [type] is "text", a dialog is displayed to edit the [info] text. If the [type] is "language" or "country", a dialog is
/// displayed with a list of choices. If the [type] is "email", no action is performed. If the [type] is "account", a confirmation dialog
/// is displayed before deleting the account. If the [type] is "data", a confirmation dialog is displayed before clearing data.

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
          } else if (widget.type == "country") {
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

  ///Confirm Dialog
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

  ///Deletion Dialog
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

  /*Future<void> _choiceDialogBuilder(
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
  }*/

  void setText(String text) {
    setState(() {
      widget.info = text;
    });
  }
}
