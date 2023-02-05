import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadRecipes {
  //List<RARecipe> recipes = [];

  Future<List<RARecipe>> getRecipes() async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request('GET', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes'));
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var response = await streamedResponse.stream.bytesToString();
      List<dynamic> body = jsonDecode(response);
      List<RARecipe> recipes = body.map((dynamic item) => RARecipe.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
