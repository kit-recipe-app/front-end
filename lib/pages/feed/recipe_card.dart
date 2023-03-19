import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

class RecipeCard extends StatelessWidget {
  final RARecipe recipe;

  const RecipeCard({required this.recipe, super.key});

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
            Image.asset(
              recipe.picture,
              width: MediaQuery.of(context).size.width,
              height: 150,
              fit: BoxFit.cover,
            ),
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
