import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';

import '../../backend_connection/load_recipes.dart';
import '../../types/recipe.dart';
import 'package:http/http.dart' as http;

class SearchRecipe extends StatefulWidget {
  final String searchWord;
  const SearchRecipe({Key? key, required this.searchWord}) : super(key: key);

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {

  List<RARecipe> myRecipes = [];


  @override
  void initState() {
    print(myRecipes);
    loadRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (RARecipe recipe in myRecipes)
          if(recipe.title.toLowerCase().startsWith(widget.searchWord.toLowerCase()) || recipe.title.toUpperCase().startsWith(widget.searchWord.toUpperCase()))
          RecipeAppRecipePreviewExploring(recipe: recipe, own: false, search: true,),
      ],
    );
  }

  Future<void> loadRecipes() async {
    List<RARecipe> recipes = await LoadRecipes().getRecipes(http.Client(), FirebaseAuth.instance);
    setState(() {
      myRecipes = recipes;
    });
  }
}
