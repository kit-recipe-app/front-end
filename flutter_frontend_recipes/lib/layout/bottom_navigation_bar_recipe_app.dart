import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/layout/navigation_bar_item.dart';

/// A BottomNavigationBar, that shows the current screen-icon
/// and lets the user navigate between the pages.
class BottomNavigationBarRecipeApp extends StatelessWidget {
  Function onChange; // A required function that is called when a navigation bar item is pressed.
                     // It takes an integer parameter that represents the selected index.
  int selectedIndex; // A required integer that represents the currently selected index.
  BottomNavigationBarRecipeApp(
      {required this.onChange, required this.selectedIndex, super.key});

  /// Returns what is shown in 'BottomNavigationBarRecipeApp'
  /// 4 icons, each for one of the 4 main-pages (feed, recipes, shopping-lists, profile)
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavigationBarItem(
              key: const Key("FeedNavigation"),
              //text: selectedIndex == 0 ? "Feed" : "",
              icon: RecipeAppIcons.homePageIcon,
              isSelected: selectedIndex == 0,
              onPressed: () {
                onChange(0);
              },
            ),
            NavigationBarItem(
              key: const Key("RecipeNavigation"),
              //text: selectedIndex == 1 ? "Rezepte" : "",
              icon: RecipeAppIcons.recipePageIcon,
              isSelected: selectedIndex == 1,
              onPressed: () {
                onChange(1);
              },
            ),
            NavigationBarItem(
              key: const Key("ShoppingNavigation"),
              //text: selectedIndex == 2 ? "Listen" : "",
              icon: RecipeAppIcons.shoppingListPageIcon,
              isSelected: selectedIndex == 2,
              onPressed: () {
                onChange(2);
              },
            ),
            NavigationBarItem(
              key: const Key("ProfileNavigation"),
              //text: selectedIndex == 3 ? "Profil" : "",
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
