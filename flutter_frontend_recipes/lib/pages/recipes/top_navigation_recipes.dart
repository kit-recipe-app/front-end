import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/navigation_switch_recipes.dart';
import 'package:flutter_frontend_recipes/shared/search_bar.dart';

class RecipeAppTopNavigation extends StatelessWidget {
  Function onChange;
  Function onFilter;
  int selectedIndex;
  Function onSearch;
  String choice;
  RecipeAppTopNavigation(
      {required this.onChange, required this.selectedIndex, required this.onSearch, required this.onFilter, required this.choice,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          RecipeAppSearchBar(onSearch: onSearch, onFilter: onFilter, choice: choice,),
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
