import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/exploring-recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/my-recipes-recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/top-navigation-recipes.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const RecipeAppExploringRecipes(),
    const RecipeAppSavedRecipes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 34,
        ),
        RecipeAppTopNavigation(
          selectedIndex: _selectedIndex,
          onChange: ((int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
        ),
        _tabs[_selectedIndex],
      ],
    );
  }
}
