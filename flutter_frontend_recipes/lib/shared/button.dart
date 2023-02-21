import 'package:flutter/material.dart';

class RAButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(shadow ? 0.25 : 0),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (icon == null)
                ? const SizedBox(
                    width: 0,
                    height: 0,
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      icon,
                      color: iconColor,
                    ),
                  ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
