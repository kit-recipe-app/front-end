import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/backend_connection/load_recipes.dart';
import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;

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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  children: [
                    RecipeAppRecipePreviewExploring(
                      recipe: RecipeExamples.testRecipe2,
                      own: false,
                      search: false,
                    ),
                    RecipeAppRecipePreviewExploring(
                      recipe: RecipeExamples.testRecipe3,
                      own: false,
                      search: false,
                    ),
                    RecipeAppRecipePreviewExploring(
                      recipe: RecipeExamples.testRecipe1,
                      own: false,
                      search: false,
                    ),
                  ],
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  children: [
                    RecipeAppRecipePreviewExploring(
                      recipe: RecipeExamples.testRecipe1,
                      own: false,
                      search: false,
                    ),
                    RecipeAppRecipePreviewExploring(
                      recipe: RecipeExamples.testRecipe2,
                      own: false,
                      search: false,
                    ),
                    RecipeAppRecipePreviewExploring(
                      recipe: RecipeExamples.testRecipe3,
                      own: false,
                      search: false,
                    ),
                  ],
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
              child: Text("Aus dem Backend"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 250,
                child: FutureBuilder(
                  future: backendLoader.getAllRecipes(http.Client(), FirebaseAuth.instance),
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
