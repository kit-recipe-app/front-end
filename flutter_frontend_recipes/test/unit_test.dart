import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("types", () {
    test("Ingredient", () {
      RAIngredient ing = RAIngredient(name: "name", unit: "g", amount: 1, calories: 0);
      expect(ing.toJson(), equals({"ingredient": {"name": "name"}, "amount": {"amount": 1, "unit": "g"}}));
      ing.multiply(2);
      expect(ing.amount, equals(2));
    });

    test("recipe", () {
      RARecipe recipe = RARecipe(picture: "picture",
          title: "title",
          description: "description",
          ingredients: [],
          manual: []);
      expect(recipe.toJson(), equals({
        "name": "title",
        "description": "description",
        "cookingInstructions": [],
        "ingredients": []
      }));
    });

      test("shopping list", () {
        RAShoppingList list = RAShoppingList(title: "title", creationDate: DateTime(2023));
        list.addItem(RAIngredient(name: "name", unit: "unit", amount: 1, calories: 0));
        list.addItem(RAIngredient(name: "name", unit: "unit", amount: 2, calories: 0));
        expect(list.items![0].amount, equals(3));
      });

  });

  test('Recipe Example', () {
    RARecipe recipe = RecipeExamples.testRecipe3;
    expect(recipe.ingredients.length, equals(4));
  });
}