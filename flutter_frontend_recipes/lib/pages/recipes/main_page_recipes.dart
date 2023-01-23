import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/exploring_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/my_recipes_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/top_navigation_recipes.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const RecipeAppExploringRecipes(),
     RecipeAppSavedRecipes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecipeAppTopNavigation(
          selectedIndex: _selectedIndex,
          onChange: ((int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
        ),
        Expanded(
          child: _tabs[_selectedIndex],
        ),
      ],
    );
  }
}
