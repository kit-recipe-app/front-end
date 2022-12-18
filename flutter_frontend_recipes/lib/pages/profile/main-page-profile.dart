import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_frontend_recipes/constants/colors.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/content_examples/initiating_examples.dart';

import 'example_profile.dart';

class ProfilMainPage extends StatelessWidget {
   ProfilMainPage({Key? key}) : super(key: key);



   //TODO:hier später echtes Profil reinmachen
   Profile currentProfile = InitiatingExamples().exampleProfiles[0];

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  String mainPageTitle = 'Profil';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDesigns.appBarBGColor,
        title: Text(
            mainPageTitle,
          style: fontStyles.appBarText,
        ),
      ),

      body: Column(
        children: [

        ],
      ),

    );
  }
}