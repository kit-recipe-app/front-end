import 'package:flutter/material.dart';
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
              key: const Key("FeedNavigation"),
              // text: "feed",
              icon: RecipeAppIcons.homePageIcon,
              isSelected: selectedIndex == 0,
              onPressed: () {
                onChange(0);
              },
            ),
            NavigationBarItem(
              key: const Key("RecipeNavigation"),
              // text: "recipes",
              icon: RecipeAppIcons.recipePageIcon,
              isSelected: selectedIndex == 1,
              onPressed: () {
                onChange(1);
              },
            ),
            NavigationBarItem(
              key: const Key("ShoppingNavigation"),
              // text: "shopping",
              icon: RecipeAppIcons.shoppingListPageIcon,
              isSelected: selectedIndex == 2,
              onPressed: () {
                onChange(2);
              },
            ),
            NavigationBarItem(
              key: const Key("ProfileNavigation"),
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
