import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/content_examples/recipe-examples.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';

class RecipeAppExploringRecipes extends StatelessWidget {
  const RecipeAppExploringRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 32, 8, 8),
              child: Text("Für dich empfohlen"),
            ),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                children: [
                  RecipeAppRecipePreviewExploring(
                    recipe: RecipeExamples.testRecipe1,
                  ),
                  RecipeAppRecipePreviewExploring(
                    recipe: RecipeExamples.testRecipe1,
                  ),
                  RecipeAppRecipePreviewExploring(
                    recipe: RecipeExamples.testRecipe1,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 32, 8, 8),
              child: Text("Saisonal"),
            ),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                children: [
                  RecipeAppRecipePreviewExploring(
                    recipe: RecipeExamples.testRecipe1,
                  ),
                  RecipeAppRecipePreviewExploring(
                    recipe: RecipeExamples.testRecipe1,
                  ),
                  RecipeAppRecipePreviewExploring(
                    recipe: RecipeExamples.testRecipe1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
