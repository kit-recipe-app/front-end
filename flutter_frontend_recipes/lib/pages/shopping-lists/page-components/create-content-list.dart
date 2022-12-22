import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/page-components/shopping-list-content-ingredient-depiction.dart';

import '../../recipes/example_recipe.dart';


class CreateContentList {

  List<Widget> getContent(List<Recipe> allRecipes) {
    List<Widget> content = [];

    for (var element in allRecipes) {
      Padding cardForRecipe = Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Card(
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                element.title,
              ),
            ),
            subtitle: IngredientDepiction().createColumnForAllIngredients(
                element.ingredients),
          ),
        ),
      );


      content.add(cardForRecipe);
    }


    return content;
  }
}

