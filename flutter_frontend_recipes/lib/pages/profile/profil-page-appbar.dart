import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';

import '../../constants/font_styles.dart';
import '../../constants/icon_designs.dart';



class BuildProfiLAppBar {

  AppBar profilAppBar(String title) {
    return AppBar(
      centerTitle: true,
      backgroundColor: RecipeAppColorStyles.appBarBGColor,
      title: Text(
        title,
        style: FontStyles.appBarText,
      ),

    );
  }

}






