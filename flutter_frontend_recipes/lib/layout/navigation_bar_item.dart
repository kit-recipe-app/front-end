import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';

class NavigationBarItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final void Function()? onPressed;

  const NavigationBarItem(
      {this.text = "",
      required this.icon,
      required this.isSelected,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: isSelected
                ? RecipeAppColorStyles.navigationBarSelectedIconColor
                : RecipeAppColorStyles
                    .navigationBarunSelectedIconColor, // black54
            /*
            shadows: <Shadow>[
              Shadow(
                  color: RecipeAppColorStyles.navigationBarSelectedIconColor,
                  blurRadius: isSelected ? 5.0 : 0)
            ],
            */
          ),
          // oder (text != null) ? Text(...) : Container()
          Visibility(
            visible: text != "",
            child: Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? RecipeAppColorStyles.navigationBarSelectedIconColor
                    : RecipeAppColorStyles.navigationBarunSelectedIconColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
