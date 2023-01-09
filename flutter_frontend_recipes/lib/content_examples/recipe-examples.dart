import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

class RecipeExamples {
  static RARecipe testRecipe1 = RARecipe(
    picture: 'assets/example_pictures/hamburger.jpg',
    title: "Burger mit Basilikum und heheh",
    description:
        "Ein gewöhnlicher Burger mit dem gewissen etwas. Basilikum verschönert nicht nur, sondern gibt dem Burger seinen ganz eigenen Character",
    ingredients: [
      RAIngredient(
        name: "Basilikum",
        unit: "Blatt",
        amount: 16,
        calories: 24,
      ),
      RAIngredient(
        name: "Brot",
        unit: "gramm",
        amount: 200,
        calories: 230,
      ),
      RAIngredient(
        name: "Mais",
        unit: "gramm",
        amount: 100,
        calories: 44,
      ),
    ],
    manual: [],
    time: 30,
    difficulty: "schwer",
  );
}
