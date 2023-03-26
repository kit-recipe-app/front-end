import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';

import '../../backend_connection/deleter.dart';
import '../../constants/color_styles.dart';
import '../../constants/font_styles.dart';
import '../../types/recipe.dart';

/// Widget that displays a List of recipes.
/// Used when user clicks on 'list_preview_recipes'
class ListRecipes extends StatefulWidget {
  final List<RARecipe> recipes; // recipes in the list
  final Function? reload; // function to reload page
  final String title; // title of the list

  const ListRecipes({Key? key, required this.recipes, this.reload, required this.title}) : super(key: key);

  @override
  State<ListRecipes> createState() => _ListRecipesState();
}

class _ListRecipesState extends State<ListRecipes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme
          .of(context)
          .canvasColor,
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor:
            RecipeAppColorStyles.navigationBarSelectedIconColor,
            title: Text(
              widget.title,
              style: FontStyles.appBarText,
            ),
          ),
          body: SizedBox(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (RARecipe recipe in widget.recipes)
                  Align(
                      alignment: Alignment.center,
                      child: RecipeAppRecipePreviewExploring(
                        search: false,
                          recipe: recipe,
                          own: true,
                          delete: () {
                            setState(() {
                              widget.recipes.remove(recipe);
                              Deleter.deleteRecipe(recipe.id);
                            });
                          },
                        favorite: widget.reload,
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
