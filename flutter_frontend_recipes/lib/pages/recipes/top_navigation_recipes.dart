import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/navigation_switch_recipes.dart';
import 'package:flutter_frontend_recipes/shared/search_bar.dart';

class RecipeAppTopNavigation extends StatelessWidget {
  Function onChange;
  int selectedIndex;
  Function onSearch;
  RecipeAppTopNavigation(
      {required this.onChange, required this.selectedIndex, required this.onSearch, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          RecipeAppSearchBar(onSearch: onSearch,),
          Visibility(
            visible: selectedIndex < 2 ? true : false,
            child: RecipeAppNavigationSwitchRecipes(
                onChange: onChange, selectedIndex: selectedIndex),
          ),
        ],
      ),
    );
  }
}
