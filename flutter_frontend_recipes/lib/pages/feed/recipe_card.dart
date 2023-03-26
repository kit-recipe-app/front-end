import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

/// A stateless widget that displays a recipe card with a picture and title.
class RecipeCard extends StatelessWidget {
  /// The recipe object to display.
  final RARecipe recipe;

  /// Creates a new [RecipeCard] instance with the given [recipe] object.
  const RecipeCard({required this.recipe, super.key});

  /// Builds the widget tree for this [RecipeCard] instance.
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            //Picture of the recipe
            (recipe.picture.startsWith('http'))
                ? Image.network(
              recipe.picture,
              width: MediaQuery.of(context).size.width,
              height: 150,
              fit: BoxFit.cover,
            )
                : Image.asset(
              recipe.picture,
              width: MediaQuery.of(context).size.width,
              height: 150,
              fit: BoxFit.cover,
            ),
            //Gradient for better visibility
            Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [
                      0,
                      0.3,
                      1,
                    ],
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: const SizedBox(height: 143)),
            //Recipe title
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
