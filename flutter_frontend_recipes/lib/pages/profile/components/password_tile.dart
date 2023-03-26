import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/password_dialog.dart';

///Password tile that shows [PasswordDialog] when tapped
class PasswordTile extends StatefulWidget {

  ///Title of tile
  final String title;

  ///Function that is called once the password is changed
  Function setPassword;
  PasswordTile({Key? key, required this.title, required this.setPassword}) : super(key: key);

  @override
  State<PasswordTile> createState() => _PasswordTileState();
}

class _PasswordTileState extends State<PasswordTile> {


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: (){
          _dialogBuilder(context, widget.title);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          height: 55,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              const Text("********")
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, String title) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return PasswordDialog(
            title: title,
            setPassword: widget.setPassword,
          );
        });
  }

}
