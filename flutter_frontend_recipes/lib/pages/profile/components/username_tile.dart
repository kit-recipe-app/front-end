import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_dialog.dart';

import '../../../backend_connection/loader.dart';
import '../../../backend_connection/putter.dart';

/// A widget that displays a tile with a title and the username, with the ability to edit the username by tapping on it.
class UsernameTile extends StatefulWidget {

  final String title;
  Widget info;
  Function setName;
  Function setFuture;
  UsernameTile({Key? key, required this.title, required this.info, required this.setName, required this.setFuture}) : super(key: key);

  @override
  State<UsernameTile> createState() => _UsernameTileState();
}

class _UsernameTileState extends State<UsernameTile> {
  /// An instance of [Putter] for making HTTP PUT requests.
  Putter putter = Putter();
  /// An instance of [Loader] for loading data
  Loader loader = Loader();
  final TextEditingController _controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: (){
          // Show the dialog and update the widget after the user sets the new name.
          _dialogBuilder(context, _controller, widget.title).then((value) => Timer(Duration(milliseconds: 500), () {widget.setFuture();}));
        },
        child: Container(
          padding: EdgeInsets.all(8),
          height: 55,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              widget.info,
            ],
          ),
        ),
      ),
    );
  }

  /// Displays a dialog where the user can set the new name for the information.
  /// When the dialog is closed, calls the [setName] callback with the new name.
  Future<void> _dialogBuilder(
      BuildContext context, TextEditingController controller, String title) {
    // Load the current username and set it as the initial text for the text field.
    Future username = loader.getUsername();
    username.then((value) => controller.text = value);
    // Show the dialog and return a future that completes when the dialog is closed.
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return TextDialog(
            controller: controller,
            title: title,
            setText: widget.setName,
          );
        });
  }

}
