import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

class RecipeAppRecipePreviewExploring extends StatelessWidget {
  final RARecipe recipe;
  const RecipeAppRecipePreviewExploring({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeOverview(recipe: recipe)),
        );
      },
      child: Container(
        width: 200,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: (recipe.picture.startsWith('http'))
                  ? Image.network(
                      recipe.picture,
                      width: 200,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      recipe.picture,
                      width: 200,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                recipe.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                recipe.description,
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: getIconBar(),
            )
          ],
        ),
      ),
    );
  }

  Widget getIconBar() {
    List<Widget> availableValues = [];
    if (recipe.getCalories() != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.calories),
            Text(
              "${recipe.getCalories()} kcal",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    if (recipe.time != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.timeIcon),
            Text(
              "${recipe.time} min.",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    if (recipe.difficulty != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.difficultyIcon),
            Text(
              (recipe.difficulty != null) ? recipe.difficulty! : "",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: availableValues,
    );
  }
}
