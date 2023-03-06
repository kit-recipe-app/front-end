import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';

import '../../backend_connection/deleter.dart';
import '../../constants/color_styles.dart';
import '../../constants/font_styles.dart';
import '../../types/recipe.dart';

class ListRecipes extends StatefulWidget {
  final List<RARecipe> recipes;
  final Function? reload;
  final String title;

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
