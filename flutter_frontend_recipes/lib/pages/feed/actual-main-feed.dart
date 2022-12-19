import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/pages/feed/recommended-recipe-card.dart';

import '../../constants/colors.dart';
import '../../constants/icon_designs.dart';
import 'last-recipe-card.dart';


class MainFeed extends StatefulWidget {
  const MainFeed({Key? key}) : super(key: key);

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  String title = 'Dashboard';
  String welcome = 'Willkommen zurück';
  String lastSeen = 'Zuletzt angesehenes Rezept';
  String recommended = 'Das könnte Ihnen schmecken';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorDesigns.appBarBGColor,
        title: Text(
          title,
          style: fontStyles.appBarText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                  welcome,
                    style: fontStyles.titleText,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 30, 0, 10),
              child: Text(
                  lastSeen,
                style: fontStyles.titleText,
              ),
            ),
            LastSeenRecipe().card,
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 20, 0, 10),
              child: Text(
                recommended,
                style: fontStyles.titleText,
              ),
            ),
            RecommendedRecipe().card,
          ],
        ),
      ),



    );
  }
}



