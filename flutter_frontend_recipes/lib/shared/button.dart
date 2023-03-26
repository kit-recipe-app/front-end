import 'package:flutter/material.dart';

/// A general, customizable Button that is used all over the app.
/// The 'onTap' function is called, when the widget is pressed.
class RAButton extends StatefulWidget {
  final Function onTap; // a required callback function that is called when the button is tapped.
  final String description; // a required string that is displayed on the button.
  final Color backgroundColor; // a color that is used as the background color of the button. The default color is black87.
  final Color textColor; // a color that is used as the text color of the button. The default color is white.
  final double margin; // a double that is used as the margin around the button. The default value is 0.
  final EdgeInsets padding; // an EdgeInsets object that is used as the padding inside the button. The default value is EdgeInsets.fromLTRB(16, 8, 16, 8).
  final bool shadow; // a boolean that determines whether a shadow is displayed around the button. The default value is true.
  final IconData? icon; // an optional IconData object that is displayed to the left of the text on the button.
  final Color? iconColor; // an optional color that is used as the color of the icon. If this value is null, the default color is used.
  const RAButton({
    required this.onTap,
    required this.description,
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
    this.margin = 0,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.shadow = true,
    this.icon,
    this.iconColor,
    super.key,
  });

  @override
  State<RAButton> createState() => _RAButtonState();
}

class _RAButtonState extends State<RAButton> {
  bool _currentlyTapped = false;

  /// Returns what is shown in the 'RAButton'.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        setState(() {
          _currentlyTapped = false;
        });
      },
      onPanDown: (details) {
        setState(() {
          _currentlyTapped = true;
        });
      },
      onPanEnd: (details) {
        setState(() {
          _currentlyTapped = false;
        });
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.all(widget.margin),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: _currentlyTapped ? Colors.black12 : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: _currentlyTapped
                  ? Colors.black.withOpacity(0.5)
                  : Colors.black.withOpacity(widget.shadow ? 0.25 : 0),
              spreadRadius: _currentlyTapped ? -5 : 0,
              blurRadius: _currentlyTapped ? 10 : 5,
              offset:
                  _currentlyTapped ? const Offset(0, 0) : const Offset(0, 4),
            ),
          ],
        ),
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (widget.icon == null)
                ? const SizedBox(
                    width: 0,
                    height: 0,
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      widget.icon,
                      color: widget.iconColor,
                    ),
                  ),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: widget.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
