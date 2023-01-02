import 'package:flutter_frontend_recipes/types/ingredient.dart';

class RARecipe {
  String picture;
  String title;
  String description;
  List<RAIngredient> ingredients;
  List<String> manual;
  List<String>? tags;
  int? time;
  String? difficulty;

  RARecipe(
      {required this.picture,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.manual,
      this.tags,
      this.time,
      this.difficulty});

  int getCalories() {
    int summedCalories = 0;
    for (RAIngredient ingredient in ingredients) {
      summedCalories += ingredient.calories;
    }
    return summedCalories;
  }
}
