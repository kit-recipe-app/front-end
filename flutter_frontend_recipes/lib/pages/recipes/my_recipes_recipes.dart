import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/backend_connection/load_recipes.dart';
import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_main_page.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_preview_recipes.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:http/http.dart' as http;

import '../../types/recipe.dart';

// myRecipes subtab of the recipe tab
class RecipeAppSavedRecipes extends StatefulWidget {
  const RecipeAppSavedRecipes({super.key});

  @override
  State<RecipeAppSavedRecipes> createState() => _RecipeAppSavedRecipesState();
}

class _RecipeAppSavedRecipesState extends State<RecipeAppSavedRecipes> {
  List<RARecipe> myRecipes = []; // recipes created by the user
  List<RARecipe> favoriteRecipes = []; // recipes the user favorites

  @override
  void initState() {
    loadRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecipeAppRecipeListPreview(
          recipes: myRecipes,
          title: "Eigene Rezepte",
          numberRecipes: myRecipes.length,
          reload: loadRecipes,
        ),
        RecipeAppRecipeListPreview(
          recipes: favoriteRecipes,
          title: "Meine Favoriten",
          numberRecipes: favoriteRecipes.length,
          reload: loadRecipes,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateRecipeMainPage()),
                ).then((_) async {
                  await Future.delayed(const Duration(seconds: 3));
                  loadRecipes();
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xff66aa44),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              child: const Text("Neues Rezept erstellen"),
            ),
          ),
        )
      ],
    );
  }

  Future<void> loadRecipes() async {
    List<RARecipe> recipes = await LoadRecipes()
        .getRecipes(http.Client(), FirebaseAuth.instance, 'user/recipes');
    setState(() {
      myRecipes = recipes;
      favoriteRecipes = [];
    });
    List<RARecipe> allRecipes = await LoadRecipes()
        .getRecipes(http.Client(), FirebaseAuth.instance, 'recipes');
    for (RARecipe recipe in myRecipes) {
      if (SharedPrefs().getFavorite(recipe.id) ?? false) {
        setState(() {
          favoriteRecipes.add(recipe);
        });
      }
    }
    for (RARecipe recipe in allRecipes) {
      if (SharedPrefs().getFavorite(recipe.id) ?? false) {
        setState(() {
          favoriteRecipes.add(recipe);
        });
      }
    }
    for (RARecipe recipe in [
      RecipeExamples.testRecipe1,
      RecipeExamples.testRecipe2,
      RecipeExamples.testRecipe3
    ]) {
      if (SharedPrefs().getFavorite(recipe.id) ?? false) {
        setState(() {
          favoriteRecipes.add(recipe);
        });
      }
    }
  }
}
