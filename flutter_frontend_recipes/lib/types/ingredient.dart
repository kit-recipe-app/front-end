import 'package:flutter_frontend_recipes/types/recipe.dart';

class RAIngredient {
  String name;
  String unit;
  int amount;
  int calories;
  String? category;
  RARecipe? recipe;
  bool done;

  // umrechnungsfaktoren für unterstütze Einheiten im Backend speichern, falls Rezept gespeichert wird übergeben
  // z.B.:  {gramm_kilogramm: 1000, ...}

  RAIngredient({
    required this.name,
    required this.unit,
    required this.amount,
    required this.calories,
    this.category,
    this.recipe,
    this.done = false,
  });

  factory RAIngredient.fromJson(Map<String, dynamic> json) {
    return RAIngredient(
      name: json['ingredient']['name'],
      unit: json['amountInformation']['unit']['name'],
      amount: json['amountInformation']['amount'].round(),
      calories: 0,
    );
  }

  factory RAIngredient.fromJsonBackend(Map<String, dynamic> json){
    return RAIngredient(
      name: json['name'],
      unit: "g",
      amount: 0,
      calories: 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "ingredient": {"name": name},
        "amount": {"amount": amount, "unit": unit}
      };

  factory RAIngredient.fromJsonLocal(Map<String, dynamic> json) {
    return RAIngredient(
      name: json['ingredient']['name'],
      unit: json['amountInformation']['unit'],
      amount: json['amountInformation']['amount'].round(),
      calories: 0,
      done: json['done'] ?? false,
    );
  }

  Map<String, dynamic> toJsonLocal() => {
        "ingredient": {"name": name},
        "amountInformation": {"amount": amount, "unit": unit},
        "done": done,
      };

  @override
  String toString() => '$amount $unit $name';

  multiply(int factor) {
    amount *= factor;
  }
}
