import 'package:flutter_frontend_recipes/pages/recipes/ingredients.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile.dart';

// Dies ist eine Klasse, die in erster Linie nur fürs Testen gedacht ist und
// am Ende wieder gelöscht werden sollte
// Das ist eine Klasse, die ein Beispiel ist, wie eine Einkaufslisten Klasse aussehen könnte
// Die Listen werden am Ende vom Backend bereitgestellt
class ShoppingList {

  String title;
  List<Recipe> allRecipes;
  List<Ingredients> allRequiredIngredients = [];
  List<Ingredients> missingIngredients = [];
  List<Profile> allMembers;
  List<String> allTags = [];

  ShoppingList({required this.title, required this.allRecipes, required this.allMembers}) {



    for (var recipe in allRecipes) {
      for (var tag in recipe.tags){
        allTags.add(tag);
      }

      for (var ingredient in recipe.ingredients) {
        allRequiredIngredients.add(ingredient);
        missingIngredients.add(ingredient);
      }
    }

  }

  // fügt neue rezepte hinzu
  void addRecipe(Recipe newRecipe){
    allRecipes.add(newRecipe);
    for (var ingredient in newRecipe.ingredients) {
      allRequiredIngredients.add(ingredient);
      missingIngredients.add(ingredient);
    }

  }

  // fügt neue personen hinzu
  void addMember(Profile member) {
    allMembers.add(member);
  }

  // soll simulieren, dass eine Zutat gekauft wird und von der Liste genommen wird
  // eventuell kann das auch anders gelöst werden
  void checkOff (Ingredients boughtIngredient) {
    if (missingIngredients.contains(boughtIngredient)) {
      missingIngredients.remove(boughtIngredient);
    }

  }




}