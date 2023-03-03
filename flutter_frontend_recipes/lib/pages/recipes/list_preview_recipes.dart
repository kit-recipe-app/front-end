import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_recipes.dart';

import '../../types/recipe.dart';

class RecipeAppRecipeListPreview extends StatelessWidget {
  final List<RARecipe> recipes;
  final String title;
  final int numberRecipes;
  const RecipeAppRecipeListPreview(
      {required this.title, required this.numberRecipes, required this.recipes, super.key});

  @override
  Widget build(BuildContext context) {
    recipes.add(RecipeExamples.testRecipe1);
    return InkWell(
      onTap: () {
        print(recipes);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListRecipes(recipes: recipes)),
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
                child: Image.asset(
                  'assets/example_pictures/hamburger.jpg',
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
