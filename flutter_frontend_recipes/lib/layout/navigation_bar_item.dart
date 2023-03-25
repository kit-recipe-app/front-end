import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';

/// Helper Widget, to be shown in the 'BottomNavigationBarRecipeApp'.
/// An icon with optional text below.
/// Calls the given 'onPressed' method if the 'NavigationBarItem' is pressed.
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

  /// Returns what is shown in 'NavigationBarItem'.
  /// The corresponding icon and text to the given data (isSelected)
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
                : Theme.of(context).colorScheme.onSecondary,
          ),
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
