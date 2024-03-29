import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/last_viewed.dart';

import 'package:flutter_frontend_recipes/pages/recipes/to_shopping_list_page.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

import '../../constants/icon_designs.dart';
import '../../types/ingredient.dart';

/// Overview of a recipe.
/// Gets rendered if user clicks on any recipe.
class RecipeOverview extends StatelessWidget {
  final RARecipe recipe; // the recipe to be shown

  const RecipeOverview({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    LastViewed().recipe = recipe;
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        left: false,
        bottom: false,
        right: false,
        child: Material(
          child: Stack(
            children: [
              ListView(
                children: [
                  (recipe.picture.startsWith('http'))
                      ? Image.network(recipe.picture)
                      : ((recipe.picture.startsWith('assets'))
                          ? Image.asset(recipe.picture)
                          : Image.file(File(recipe.picture))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recipe.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: getIconBar(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Text(
                      recipe.description,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Wrap(
                      children: [
                        if (recipe.tags != null)
                          for (var i in recipe.tags!)
                            Container(
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                child: (Text(i)),
                              ),
                            )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Zutaten (4 Personen)",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        for (RAIngredient i in recipe.ingredients)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(i.toString()),
                          )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Zubereitung",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        for (var i = 0; i < (recipe.manual.length); i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text("${i + 1}. ${recipe.manual[i]}"),
                          )
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      key: const Key("ToShoppingListButton"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ToShoppingList(
                                    recipe: recipe,
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: const Color(0xff66aa44),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      child: const Text("Zu Einkaufslisten hinzufügen"),
                    ),
                  )
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, blurRadius: 32.0)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // iconbar showing calories, difficulty and time
  Widget getIconBar() {
    List<Widget> availableValues = [];
    if (recipe.calories != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.calories),
            Text(
              "${recipe.calories} kcal",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    if (recipe.time != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.timeIcon),
            Text(
              "${recipe.time} min.",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    if (recipe.difficulty != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.difficultyIcon),
            Text(
              (recipe.difficulty != null) ? recipe.difficulty! : "",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: availableValues,
    );
  }
}
