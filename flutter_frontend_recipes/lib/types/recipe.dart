import 'package:flutter_frontend_recipes/types/ingredient.dart';

class RARecipe {
  String id;
  String picture;
  String title;
  String description;
  List<RAIngredient> ingredients;
  List<String> manual;
  List<String>? tags;
  int? time;
  String? difficulty;
  bool favorite;

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

  Map<String, dynamic> toJson() =>{
    "name": title,
    "description": description,
    "cookingInstructions": [for (String instruction in manual) {"instruction": instruction}],
    "ingredients": [for (RAIngredient ingredient in ingredients) ingredient.toJson()]
  };

  int? getCalories() {
    int summedCalories = 0;
    for (RAIngredient ingredient in ingredients) {
      summedCalories += ingredient.calories;
    }
    return summedCalories;
  }
}
