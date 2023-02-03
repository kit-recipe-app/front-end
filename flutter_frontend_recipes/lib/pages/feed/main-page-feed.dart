import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';
import 'package:flutter_frontend_recipes/pages/feed/recipe_card.dart';


class MainFeed extends StatefulWidget {
  const MainFeed({Key? key}) : super(key: key);

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  String title = 'Dashboard';
  String welcome = 'Willkommen zurück';
  String lastSeen = 'Zuletzt angesehenes Rezept';
  String recommended = 'Das könnte Ihnen schmecken';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: RecipeAppColorStyles.navigationBarSelectedIconColor,
        title: Text(
          title,
          style: FontStyles.appBarText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    welcome,
                    style: FontStyles.titleText,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 30, 0, 5),
              child: Text(
                lastSeen,
                //style: FontStyles.titleText,
              ),
            ),
            RecipeCard(recipe: RecipeExamples.testRecipe2),

            Padding(
              padding: const EdgeInsets.fromLTRB(2, 40, 0, 5),
              child: Text(
                recommended,
                //style: FontStyles.titleText,
              ),
            ),
           RecipeCard(recipe: RecipeExamples.testRecipe1),
          ],
        ),
      ),
    );
  }
}
