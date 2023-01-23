import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';

import '../../types/recipe.dart';

class ListRecipes extends StatelessWidget {
  final List<RARecipe> recipes;

  const ListRecipes({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (RARecipe recipe in recipes)
          RecipeAppRecipePreviewExploring(recipe: recipe)
      ],
    );
  }
}
