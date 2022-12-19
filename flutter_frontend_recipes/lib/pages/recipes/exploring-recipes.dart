import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';

class RecipeAppExploringRecipes extends StatelessWidget {
  const RecipeAppExploringRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            children: const [
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
              RecipeAppRecipePreviewExploring(),
            ],
          ),
        ),
      ],
    );
  }
}
