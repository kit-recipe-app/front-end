import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/ingredients.dart';


// Dies ist eine Klasse, die in erster Linie nur fürs Testen gedacht ist und
// am Ende wieder gelöscht werden sollte
// Das ist eine Klasse, die ein Beispiel ist, wie eine Rezepte Klasse aussehen könnte
// Die Rezepte werden am Ende vom Backend bereitgestellt
class Recipe {
  String title;
  String description;
  int calories;
  int time;
  bool vegetarian;
  String difficulty;
  List<Ingredients> ingredients;


  Recipe({required this.title, required this.description,
    required this.calories, required this.time, required this.vegetarian,
    required this.difficulty, required this.ingredients}) {

  }


}

