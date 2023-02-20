import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/choice_dialog.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_dialog.dart';

class TextTile extends StatefulWidget {
  final String text;
  String info;
  final String type;

  TextTile({Key? key, required this.text, required this.info, required this.type})
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
        onTap: () {
          if(widget.type == "text") {
            _dialogBuilder(context, _controller, widget.text);
          }else if (widget.type == "language"){
            _choiceDialogBuilder(context, widget.text, languages);
          }else if (widget.type == "country"){
            _choiceDialogBuilder(context, widget.text, countries);
          }else if (widget.type == "email"){}
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

  Future<void> _choiceDialogBuilder(
      BuildContext context, String title, List<String> values) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ChoiceDialog(title: title, values: values, standard: widget.info, setText: setText);
        });
  }

  void setText(String text) {
    setState(() {
      widget.info = text;
    });
  }
}
