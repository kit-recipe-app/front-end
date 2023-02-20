import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/layout/navigation_bar_item.dart';

class BottomNavigationBarRecipeApp extends StatelessWidget {
  Function onChange;
  int selectedIndex;
  BottomNavigationBarRecipeApp(
      {required this.onChange, required this.selectedIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavigationBarItem(
              // text: "feed",
              icon: RecipeAppIcons.homePageIcon,
              isSelected: selectedIndex == 0,
              onPressed: () {
                onChange(0);
              },
            ),
            NavigationBarItem(
              // text: "recipes",
              icon: RecipeAppIcons.recipePageIcon,
              isSelected: selectedIndex == 1,
              onPressed: () {
                onChange(1);
              },
            ),
            NavigationBarItem(
              // text: "shopping",
              icon: RecipeAppIcons.shoppingListPageIcon,
              isSelected: selectedIndex == 2,
              onPressed: () {
                onChange(2);
              },
            ),
            NavigationBarItem(
              // text: "profile",
              icon: RecipeAppIcons.profilePageIcon,
              isSelected: selectedIndex == 3,
              onPressed: () {
                onChange(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
