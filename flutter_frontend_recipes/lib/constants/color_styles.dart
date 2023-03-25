import 'package:flutter/material.dart';

// Diese Klasse enthält die Farben, die in der App verwendet werden
class RecipeAppColorStyles {
  // Das sind Farben, die für die Seiten wichtig sind
  static Color? backGroundColor = Colors.white;
  static Color recipeAppMainColor = const Color(0xff66aa44);

  //Auth Colors
  static List<Color> loginRegisterBackground = [
    const Color(0xff66aa44),
    const Color(0xffeeeeee),
  ];

  // Navigation Bar Styles
  /*static List<Color> navigationBarBGFade = [
    const Color(0xffeeeeee),
    const Color(0xffeeeeee),
  ];*/

  static Color navigationBarSelectedIconColor = const Color(0xff66aa44);
  static Color navigationBarunSelectedIconColor =
      const Color(0xfff111111); //.withOpacity(0.54);
  Color? listTileColor = Colors.white;
  //static Color? addButtonColor = Colors.grey[300];
  Color? shoppingListBGColor = Colors.white;

  // Textfarben
  static Color selectedTextColor = const Color(0xff66aa44);
  static Color unSelectedTextColor = const Color(0x00000000).withOpacity(0.54);

}
