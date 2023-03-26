import 'package:flutter/material.dart';

/// This class contains colors for the app
class RecipeAppColorStyles {

  static Color? backGroundColor = Colors.white;
  static Color recipeAppMainColor = const Color(0xff66aa44);

  ///Auth Colors
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
  /*Color? listTileColor = Colors.white;
  static Color? addButtonColor = Colors.grey[300];
  Color? shoppingListBGColor = Colors.white;*/

  ///Colors for text
  static Color selectedTextColor = const Color(0xff66aa44);
  static Color unSelectedTextColor = const Color(0x00000000).withOpacity(0.54);

  ///light theme
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff66aa44),
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Color(0xffb00020),
          onError: Colors.white,
          background:  Colors.white.withOpacity(0.9),
          onBackground: Colors.black,
          surface:  Colors.white,
          onSurface: Colors.black,
          secondaryContainer: Colors.white.withOpacity(0.9)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ));

  ///dark theme
  static ThemeData darkTheme = ThemeData(
    //scaffoldBackgroundColor: Colors.grey.shade800,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff66aa44),
          onPrimary: Colors.black,
          secondary: Colors.black,
          onSecondary: Colors.white,
          error: Color(0xffcf6679),
          onError: Colors.black,
          background: Colors.grey.shade700,
          onBackground: Colors.white,
          surface: Color(0xff121212),
          onSurface: Colors.white,
          secondaryContainer: Colors.grey.shade700),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff121212),
      ));
}
