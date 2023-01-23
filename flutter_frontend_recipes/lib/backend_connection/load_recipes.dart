import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadRecipes extends StatefulWidget {
  const LoadRecipes({super.key});

  @override
  State<LoadRecipes> createState() => _LoadRecipesState();
}

class _LoadRecipesState extends State<LoadRecipes> {
  List<RARecipe> recipes = [];

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    final response = await http.get(
      Uri.parse(
          'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes'),
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      setState(() {
        recipes = body.map((dynamic item) => RARecipe.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (RARecipe recipe in recipes)
          RecipeAppRecipePreviewExploring(recipe: recipe)
      ],
    );
  }
}
