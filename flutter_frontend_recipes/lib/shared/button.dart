import 'package:flutter/material.dart';

class RAButton extends StatefulWidget {
  final Function onTap;
  final String description;
  final Color backgroundColor;
  final Color textColor;
  final double margin;
  final EdgeInsets padding;
  final bool shadow;
  final IconData? icon;
  final Color? iconColor;
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
