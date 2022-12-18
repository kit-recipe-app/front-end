import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/font_styles.dart';
import '../../constants/icon_designs.dart';



class BuildProfiLAppBar {

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  String mainPageTitle = 'Profil';

  AppBar profilAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: colorDesigns.appBarBGColor,
      title: Text(
        mainPageTitle,
        style: fontStyles.appBarText,
      ),

    );
  }

}






