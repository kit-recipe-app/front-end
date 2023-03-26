import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';

import '../../types/recipe.dart';

/// Singleton, providing access to the most recently viewed recipe
class LastViewed {
  static final LastViewed _instance = LastViewed._internal();

  factory LastViewed() => _instance;

  LastViewed._internal(){
    _recipe = RecipeExamples.testRecipe2;
  }

  late RARecipe _recipe;

  set recipe(RARecipe value) {
    _recipe = value;
  }

  RARecipe get recipe => _recipe;
}