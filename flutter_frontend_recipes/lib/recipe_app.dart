import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/layout/bottom_navigation_bar_recipe_app.dart';
import 'package:flutter_frontend_recipes/pages/feed/main-page-feed.dart';
import 'package:flutter_frontend_recipes/pages/profile/main-page-profile.dart';
import 'package:flutter_frontend_recipes/pages/recipes/main_page_recipes.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/main-page-shopping-lists.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const MainFeed(),
    const RecipeScreen(),
    const MainPageShoppingLists(),
    const ProfileMainPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: RecipeAppColorStyles.backGroundColor,
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
