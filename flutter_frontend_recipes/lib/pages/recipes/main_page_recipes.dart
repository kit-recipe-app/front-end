import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/exploring_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/my_recipes_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/search_recipe.dart';
import 'package:flutter_frontend_recipes/pages/recipes/top_navigation_recipes.dart';

/// MainPage of the recipe-tab in the app
class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  int _selectedIndex = 0; // index of the selected subpage
  String _searchWord = "";
  String _filterWord = "Übersicht";

  final List<Widget> _tabs = [
    const RecipeAppExploringRecipes(),
    RecipeAppSavedRecipes(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          RecipeAppTopNavigation(
            choice: _filterWord,
            onSearch: (String searchWord) {
              setState(() {
                _searchWord = searchWord;
                if (_searchWord != "") {
                  if (_tabs.length == 2) {
                    _tabs.add(
                      SearchRecipe(
                        searchWord: _searchWord,
                        filterWord: _filterWord,
                      ),
                    );
                  } else {
                    _tabs[2] = SearchRecipe(
                      searchWord: _searchWord,
                      filterWord: _filterWord,
                    );
                  }
                  _selectedIndex = 2;
                } else {
                  _selectedIndex = 0;
                }
              });
            },
            onFilter: (String filterWord) {
              setState(() {
                _filterWord = filterWord;
                if (_filterWord != "Übersicht") {
                  if (_tabs.length == 2) {
                    _tabs.add(
                      SearchRecipe(
                        searchWord: _searchWord,
                        filterWord: _filterWord,
                      ),
                    );
                  } else {
                    _tabs[2] = SearchRecipe(
                      searchWord: _searchWord,
                      filterWord: _filterWord,
                    );
                  }
                  _selectedIndex = 2;
                } else {
                  _selectedIndex = 0;
                }
              });
            },
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
      ),
    );
  }
}
