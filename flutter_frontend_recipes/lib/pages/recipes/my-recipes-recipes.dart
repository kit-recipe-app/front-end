import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_preview_recipes.dart';

class RecipeAppSavedRecipes extends StatelessWidget {
  const RecipeAppSavedRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
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
      ],
    );
  }
}
