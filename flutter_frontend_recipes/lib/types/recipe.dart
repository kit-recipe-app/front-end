import 'package:flutter_frontend_recipes/types/ingredient.dart';

///RARecipe represents a recipe object in the Recipe App.
///It contains information about the recipe, such as its name, picture, description, ingredients, and manual.
class RARecipe {
  String id; // The unique ID of the recipe.
  String picture; // The URL of the recipe's picture.
  String title; // The title of the recipe.
  String description; // he description of the recipe.
  List<RAIngredient> ingredients; // The list of ingredients of the recipe.
  List<String> manual; // The list of steps to cook the recipe.
  List<String>? tags; // The list of tags associated with the recipe.
  int? time; // The expected time required to cook the recipe.
  String? difficulty; // The difficulty level of the recipe.
  bool favorite; // Whether the recipe is marked as a favorite.

  /// Constructor
  RARecipe(
      {required this.picture,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.manual,
      this.id = "",
        this.favorite = false,
      this.tags,
      this.time,
      this.difficulty});

  /// Factory-Constructor that creates a RARecipe object from a JSON object.
  factory RARecipe.fromJson(Map<String, dynamic> json) {
    return RARecipe(
      picture: (json['imageData'] == null)
          ? 'assets/example_pictures/standard_picture.jpg'
          : 'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/images/${json['imageData']['name']}',
      title: json['name'],
      id: json['id'],
      description: json['description'],
      ingredients: [
        for (Map<String, dynamic> ingredient in json['ingredients'])
          RAIngredient.fromJson(ingredient)
      ],
      manual: [
        for (Map step in json['cookingInstructions']) step['instruction']
      ],
    );
  }

  /// Method that returns the recipe object as a JSON object.
  Map<String, dynamic> toJson() =>{
    "name": title,
    "description": description,
    "cookingInstructions": [for (String instruction in manual) {"instruction": instruction}],
    "ingredients": [for (RAIngredient ingredient in ingredients) ingredient.toJson()]
  };

  /// Method that calculates and returns the total number of calories in the recipe.
  int? getCalories() {
    int summedCalories = 0;
    for (RAIngredient ingredient in ingredients) {
      summedCalories += ingredient.calories;
    }
    return summedCalories;
  }
}
