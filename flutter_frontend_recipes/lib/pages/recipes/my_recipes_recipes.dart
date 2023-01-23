import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_main_page.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/name_recipe.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_preview_recipes.dart';

import '../../types/recipe.dart';

class RecipeAppSavedRecipes extends StatefulWidget {


  const RecipeAppSavedRecipes({super.key});

  @override
  State<RecipeAppSavedRecipes> createState() => _RecipeAppSavedRecipesState();
}

class _RecipeAppSavedRecipesState extends State<RecipeAppSavedRecipes> {
  List<RARecipe> myRecipes = [];

  void pushRecipe(RARecipe recipe) {
    myRecipes.add(recipe);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        RecipeAppRecipeListPreview(
          recipes: myRecipes,
          title: "Eigene Rezepte",
          numberRecipes: 0,
        ),
        RecipeAppRecipeListPreview(
          recipes: [],
          title: "Meine Favoriten",
          numberRecipes: 18,
        ),
        RecipeAppRecipeListPreview(
          recipes: [],
          title: "Zuletzt gekocht",
          numberRecipes: 8,
        ),
        RecipeAppRecipeListPreview(
          recipes: [],
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
                          CreateRecipeMainPage()),
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
