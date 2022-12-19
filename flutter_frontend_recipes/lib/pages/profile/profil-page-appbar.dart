import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/font_styles.dart';
import '../../constants/icon_designs.dart';



class BuildProfiLAppBar {

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();


  AppBar profilAppBar(String title) {
    return AppBar(
      centerTitle: true,
      backgroundColor: colorDesigns.appBarBGColor,
      title: Text(
        title,
        style: fontStyles.appBarText,
      ),

    );
  }

}






