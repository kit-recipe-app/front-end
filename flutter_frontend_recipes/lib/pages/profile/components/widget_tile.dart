import 'package:flutter/material.dart';

class WidgetTile extends StatefulWidget {

  final String text;
  Widget info;

  WidgetTile({Key? key, required this.text, required this.info}) : super(key: key);

  @override
  State<WidgetTile> createState() => _WidgetTileState();
}

class _WidgetTileState extends State<WidgetTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Container(
        padding: EdgeInsets.all(8),
        height: 55,
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text),
            widget.info,
          ],
        ),
      ),
    );
  }
}
