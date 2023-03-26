import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/layout/bottom_navigation_bar_recipe_app.dart';
import 'package:flutter_frontend_recipes/pages/feed/main-page-feed.dart';
import 'package:flutter_frontend_recipes/pages/profile/main_page_profile.dart';
import 'package:flutter_frontend_recipes/pages/recipes/main_page_recipes.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/main_page_shopping_lists.dart';

/// The RecipeApp widget is the top-level widget for the Recipe App.
/// It is a stateful widget which toggles the page shown to the user.
/// It contains a bottom navigation bar and a list of pages, where each
/// page is represented by a widget.
class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  int _currentIndex = 0; // The index of the current page.
  final List<Widget> _pages = [
    const MainFeed(
      key: Key("MainFeedPage"),
    ),
    const RecipeScreen(key: Key("RecipePage")),
    const NewMainPageShoppingLists(
      key: Key("ShoppingListsPage"),
    ),
    const ProfilePage(
      key: Key("ProfilePage"),
    ),
  ]; // contains the widgets that represent the different pages in the app.

  /// Returns what is shown in the app.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
          body: _pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBarRecipeApp(
            selectedIndex: _currentIndex,
            onChange: ((int index) {
              setState(() {
                _currentIndex = index;
              });
            }),
          ),
        ),
      ),
    );
  }
}
