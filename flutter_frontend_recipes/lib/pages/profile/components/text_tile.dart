import 'package:flutter/material.dart';

class TextTile extends StatefulWidget {

  final String text;
  String info;

  TextTile({Key? key, required this.text, required this.info}) : super(key: key);

  @override
  State<TextTile> createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onPrimary,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(8),
          height: 55,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text),
              Text(widget.info, style: TextStyle(color: Colors.grey.shade600,))
            ],
          ),
        ),
      ),
    );
  }
}
