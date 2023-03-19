import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/backend_connection/load_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_main_page.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_preview_recipes.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:http/http.dart' as http;


import '../../types/recipe.dart';

class RecipeAppSavedRecipes extends StatefulWidget {


  const RecipeAppSavedRecipes({super.key});

  @override
  State<RecipeAppSavedRecipes> createState() => _RecipeAppSavedRecipesState();
}

class _RecipeAppSavedRecipesState extends State<RecipeAppSavedRecipes> {
  List<RARecipe> myRecipes = [];
  List<RARecipe> favoriteRecipes = [];


  @override
  void initState() {
    loadRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        RecipeAppRecipeListPreview(
          recipes: myRecipes,
          title: "Eigene Rezepte",
          numberRecipes: myRecipes.length,
          reload: reloadFavorites,
        ),
        RecipeAppRecipeListPreview(
          recipes: favoriteRecipes,
          title: "Meine Favoriten",
          numberRecipes: favoriteRecipes.length,
          reload: reloadFavorites,
        ),
        RecipeAppRecipeListPreview(
          recipes: [],
          title: "Zuletzt gekocht",
          numberRecipes: 0,
        ),
        RecipeAppRecipeListPreview(
          recipes: [],
          title: "Weihnachtsessen",
          numberRecipes: 0,
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

  Future<void> loadRecipes() async {
    List<RARecipe> recipes = await LoadRecipes().getRecipes(http.Client(), FirebaseAuth.instance, false);
    setState(() {
      myRecipes = recipes;
    });
    for (RARecipe recipe in myRecipes) {
      if(SharedPrefs().getFavorite(recipe.id) ?? false){
        setState(() {
          favoriteRecipes.add(recipe);
        });
      }
    }
  }

  void reloadFavorites(){
    setState(() {
      favoriteRecipes = [];
    });
    for (RARecipe recipe in myRecipes) {
      if(SharedPrefs().getFavorite(recipe.id) ?? false){
        setState(() {
          favoriteRecipes.add(recipe);
        });
      }
    }
  }


}
