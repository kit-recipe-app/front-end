import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_recipes.dart';

import '../../types/recipe.dart';

/// Widget that displays a preview of a list of recipes.
/// Tapping on the widget will navigate to the full list of recipes.
/// The preview displays the title of the recipe list, the number of
/// recipes in the list, and an image of the first recipe in the
/// list (if available).
class RecipeAppRecipeListPreview extends StatelessWidget {
  final List<RARecipe> recipes;
  final String title;
  final int numberRecipes;
  final Function? reload;
  const RecipeAppRecipeListPreview(
      {required this.title, required this.numberRecipes, required this.recipes, super.key, this.reload});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListRecipes(recipes: recipes, reload: reload, title: title,)),
        );
        ;
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: numberRecipes == 0 ? Image.asset(
                  'assets/example_pictures/standard_picture.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ) : (recipes[0].picture.startsWith('http'))
                    ? Image.network(
                  recipes[0].picture,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  recipes[0].picture,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$numberRecipes Rezepte",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
