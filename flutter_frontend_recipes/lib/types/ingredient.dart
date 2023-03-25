import 'package:flutter_frontend_recipes/types/recipe.dart';

/// 'RAIngredient' represents an ingredient of a recipe or an ite in a shopping-list.
class RAIngredient {
  String name; // A string that holds the name of the ingredient.
  String unit; // A string that holds the unit of unit of the ingredient.
  int amount; // An integer that holds the amount of the ingredient required.
  int calories; // An integer that holds the amount of calories per serving.
  String? category; // An optional string that holds the category of the ingredient (e.g. dairy, meat, vegetable).
  RARecipe? recipe; // An optional reference to the recipe object the ingredient belongs to.
  bool done; // A boolean that indicates whether the ingredient has been marked as done.

  /// Constructor
  RAIngredient({
    required this.name,
    required this.unit,
    required this.amount,
    required this.calories,
    this.category,
    this.recipe,
    this.done = false,
  });

  /// A factory constructor for creating an instance of RAIngredient from a JSON object returned by an API.
  factory RAIngredient.fromJson(Map<String, dynamic> json) {
    return RAIngredient(
      name: json['ingredient']['name'],
      unit: json['amountInformation']['unit']['name'],
      amount: json['amountInformation']['amount'].round(),
      calories: 0,
    );
  }

  /// A factory constructor for creating an instance of RAIngredient from a JSON object returned by the backend API.
  factory RAIngredient.fromJsonBackend(Map<String, dynamic> json){
    return RAIngredient(
      name: json['name'],
      unit: "g",
      amount: 0,
      calories: 0,
    );
  }

  /// A method that converts an instance of RAIngredient to a JSON object.
  Map<String, dynamic> toJson() => {
        "ingredient": {"name": name},
        "amount": {"amount": amount, "unit": unit}
      };

  /// A factory constructor for creating an instance of RAIngredient from a JSON object returned by the local database.
  factory RAIngredient.fromJsonLocal(Map<String, dynamic> json) {
    return RAIngredient(
      name: json['ingredient']['name'],
      unit: json['amountInformation']['unit'],
      amount: json['amountInformation']['amount'].round(),
      calories: 0,
      done: json['done'] ?? false,
    );
  }

  /// A method that converts an instance of RAIngredient to a JSON object to be stored in the local database.
  Map<String, dynamic> toJsonLocal() => {
        "ingredient": {"name": name},
        "amountInformation": {"amount": amount, "unit": unit},
        "done": done,
      };

  @override
  String toString() => '$amount $unit $name';

  /// A method that multiplies the amount of the ingredient by a given factor.
  multiply(int factor) {
    amount *= factor;
  }
}
