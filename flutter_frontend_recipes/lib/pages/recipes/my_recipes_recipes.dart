import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/name_recipe.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_preview_recipes.dart';

class RecipeAppSavedRecipes extends StatelessWidget {
  const RecipeAppSavedRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        RecipeAppRecipeListPreview(
          title: "Meine Favoriten",
          numberRecipes: 18,
        ),
        RecipeAppRecipeListPreview(
          title: "Zuletzt gekocht",
          numberRecipes: 8,
        ),
        RecipeAppRecipeListPreview(
          title: "Familienessen",
          numberRecipes: 22,
        ),
        RecipeAppRecipeListPreview(
          title: "Weihnachtsessen",
          numberRecipes: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NameRecipe()),
                );
              },
              child: const Text("Neues Rezept erstellen"),
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xff66aa44),
                  textStyle:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        )],
    );
  }
}
