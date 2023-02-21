import 'package:flutter/material.dart';

import '../../../constants/font_styles.dart';



class BuildProfiLAppBar {

  AppBar profilAppBar(String title) {
    return AppBar(
      centerTitle: true,
      backgroundColor: const Color(0xff66aa44),
      title: Text(
        title,
        style: FontStyles.appBarText,
      ),

    );
  }

}






