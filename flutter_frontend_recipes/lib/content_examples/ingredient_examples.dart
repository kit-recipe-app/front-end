import 'package:flutter/material.dart';

import '../types/ingredient.dart';

class IngredientExamples {
  static List<DropdownMenuItem> ingredients1 = [
    DropdownMenuItem(
      child: Text(RAIngredient(
        name: "Basilikum",
        unit: "Blatt",
        amount: 16,
        calories: 24,
      ).toString())
    ),
  ];

  static List<RAIngredient> ingredients2 = [
    RAIngredient(
      name: "Basilikum",
      unit: "Blatt",
      amount: 16,
      calories: 24,
    ),
    RAIngredient(
      name: "Apfel",
      unit: "Blatt",
      amount: 16,
      calories: 24,
    ),
    RAIngredient(
      name: "Lachs",
      unit: "Blatt",
      amount: 16,
      calories: 24,
    )
  ];
}
