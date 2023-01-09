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
        name: "Hackfleisch",
        unit: "gramm",
        amount: 300,
        calories: 720,
      ),
    ],
    manual: [],
    time: 50,
    difficulty: "mittel",
  );

  static RARecipe testRecipe2 = RARecipe(
    picture: 'assets/example_pictures/salmon.jpg',
    title: "Lachsfilet mit Sesamsoße",
    description:
        "Lachsfilet, gebraten in der Pfanne mit leckerer Sesam-Soja-Soße",
    ingredients: [
      RAIngredient(
        name: "Lachsfilet",
        unit: "gramm",
        amount: 300,
        calories: 630,
      ),
      RAIngredient(
        name: "Sojasoße",
        unit: "ml",
        amount: 80,
        calories: 130,
      ),
      RAIngredient(
        name: "Sesamkörner",
        unit: "gramm",
        amount: 40,
        calories: 140,
      ),
    ],
    manual: [],
    time: 30,
    difficulty: "schwer",
  );

  static RARecipe testRecipe3 = RARecipe(
    picture: 'assets/example_pictures/pizza.jpg',
    title: "Pizza Margherita",
    description:
        "Eine klassische Pizza Margherita, mit gutem Mozarella und selbstgemachter Tomatensoße",
    ingredients: [
      RAIngredient(
        name: "Tomaten",
        unit: "gramm",
        amount: 200,
        calories: 90,
      ),
      RAIngredient(
        name: "Teig",
        unit: "gramm",
        amount: 250,
        calories: 479,
      ),
      RAIngredient(
        name: "Mozarella",
        unit: "gramm",
        amount: 150,
        calories: 370,
      ),
      RAIngredient(
        name: "Gouda, gerieben",
        unit: "gramm",
        amount: 100,
        calories: 340,
      ),
    ],
    manual: [],
    time: 20,
    difficulty: "leicht",
  );
}
