import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadRecipes {
  //List<RARecipe> recipes = [];

  Future<List<RARecipe>> getRecipes() async {
    final response = await http.get(
      Uri.parse(
          'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes'),
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      List<RARecipe> recipes = body.map((dynamic item) => RARecipe.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
