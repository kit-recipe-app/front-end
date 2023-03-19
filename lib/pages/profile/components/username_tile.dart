import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_dialog.dart';

import '../../../backend_connection/loader.dart';
import '../../../backend_connection/putter.dart';

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

  Putter putter = Putter();
  Loader loader = Loader();
  final TextEditingController _controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: (){
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

  Future<void> _dialogBuilder(
      BuildContext context, TextEditingController controller, String title) {
    Future username = loader.getUsername();
    username.then((value) => controller.text = value);
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
