import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/backend_connection/load_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;

/// Widget that displays a list of recipes. It fetches the recipes from
/// a backend server using HTTP requests and displays them in a horizontal list.
class RecipeAppExploringRecipes extends StatefulWidget {
  const RecipeAppExploringRecipes({super.key});

  @override
  State<RecipeAppExploringRecipes> createState() =>
      _RecipeAppExploringRecipesState();
}

class _RecipeAppExploringRecipesState extends State<RecipeAppExploringRecipes> {
  LoadRecipes backendLoader = LoadRecipes();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Für dich empfohlen"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 250,
                child: FutureBuilder(
                  future: backendLoader.getRecipes(http.Client(),
                      FirebaseAuth.instance, 'recipes/recommended'),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RARecipe>> snapshot) {
                    if (snapshot.hasData) {
                      List<RARecipe> recipes = snapshot.data!;
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        children: recipes
                            .map(
                              (RARecipe recipe) =>
                                  RecipeAppRecipePreviewExploring(
                                recipe: recipe,
                                own: false,
                                search: false,
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Saisonal"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 250,
                child: FutureBuilder(
                  future: backendLoader.getRecipes(
                      http.Client(), FirebaseAuth.instance, 'recipes/saisonal'),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RARecipe>> snapshot) {
                    if (snapshot.hasData) {
                      List<RARecipe> recipes = snapshot.data!;
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        children: recipes
                            .map(
                              (RARecipe recipe) =>
                                  RecipeAppRecipePreviewExploring(
                                recipe: recipe,
                                own: false,
                                search: false,
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Alle Rezepte"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 250,
                child: FutureBuilder(
                  future: backendLoader.getRecipes(
                      http.Client(), FirebaseAuth.instance, 'recipes'),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RARecipe>> snapshot) {
                    if (snapshot.hasData) {
                      List<RARecipe> recipes = snapshot.data!;
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        children: recipes
                            .map(
                              (RARecipe recipe) =>
                                  RecipeAppRecipePreviewExploring(
                                recipe: recipe,
                                own: false,
                                search: false,
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
