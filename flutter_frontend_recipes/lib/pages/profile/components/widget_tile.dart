import 'package:flutter/material.dart';

///A stateful widget that displays a text and a widget side by side in a material container. The widget can be updated dynamically.
class WidgetTile extends StatefulWidget {

  /// The text to display on the left side of the widget.
  final String text;

  /// The widget to display on the right side of the text.
  Widget info;

  WidgetTile({Key? key, required this.text, required this.info}) : super(key: key);

  @override
  State<WidgetTile> createState() => _WidgetTileState();
}

class _WidgetTileState extends State<WidgetTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
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
