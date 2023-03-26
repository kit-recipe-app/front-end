import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadRecipes {
  /*Future<List<RARecipe>> getRecipesOld(http.Client client) async {
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
  }*/

  Future<List<RARecipe>> getRecipes(
      http.Client client, FirebaseAuth auth, bool all) async {
    String uri = !all
        ? 'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user/recipes'
        : 'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes';
    final token = await auth.currentUser!.getIdToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(Uri.parse(uri), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      print("test loader");
      print(body);
      List<RARecipe> recipes =
          body.map((dynamic item) => RARecipe.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  /*Future<List<RARecipe>> getAllRecipes(http.Client client, FirebaseAuth auth) async {
    final token = await auth.currentUser!.getIdToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      List<RARecipe> recipes = body.map((dynamic item) => RARecipe.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }*/
}
