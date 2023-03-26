import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';
import 'package:flutter_frontend_recipes/pages/feed/recipe_card.dart';
import 'package:flutter_frontend_recipes/pages/recipes/last_viewed.dart';


/// A stateful widget that represents the main feed of the app.
class MainFeed extends StatefulWidget {
  const MainFeed({Key? key}) : super(key: key);

  @override
  State<MainFeed> createState() => _MainFeedState();
}

/// The state of the [MainFeed] widget.
class _MainFeedState extends State<MainFeed> {
  String title = 'Dashboard';
  String welcome = 'Willkommen zurück';
  String lastSeen = 'Zuletzt angesehenes Rezept';
  String recommended = 'Das könnte Ihnen schmecken';

  @override
  Widget build(BuildContext context) {
    // Create a new instance of the [LastViewed] class.
    LastViewed _lastViewed = LastViewed();
    //Scaffold with Preview of most recently viewed Recipe and recommended Recipe
    return Scaffold(
      // The app bar of the page.
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: RecipeAppColorStyles.navigationBarSelectedIconColor,
        title: Text(
          title,
          style: FontStyles.appBarText,
        ),
      ),
      // The body of the page.
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // The welcome message.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    welcome,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // The last viewed recipe.
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 30, 0, 5),
              child: Text(
                lastSeen,
                //style: FontStyles.titleText,
              ),
            ),
            // Display the last viewed recipe card.
            RecipeCard(recipe: _lastViewed.recipe),
            // The recommended recipes section.
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 40, 0, 5),
              child: Text(
                recommended,
                //style: FontStyles.titleText,
              ),
            ),
            // Display a recommended recipe card.
           RecipeCard(recipe: RecipeExamples.testRecipe1),
          ],
        ),
      ),
    );
  }
}
