import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/navigation-switch-recipes.dart';
import 'package:flutter_frontend_recipes/shared/search_bar.dart';

class RecipeAppTopNavigation extends StatelessWidget {
  Function onChange;
  int selectedIndex;
  RecipeAppTopNavigation(
      {required this.onChange, required this.selectedIndex, super.key});


  String textLeftTab = "Entdecken";
  String textRightTab = "Meine Rezepte";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const RecipeAppSearchBar(),
          RecipeAppNavigationSwitchBasicLayout(
              onChange: onChange, selectedIndex: selectedIndex,
            textLeftTab: textLeftTab, textRightTab: textRightTab,),
        ],
      ),
    );
  }
}
