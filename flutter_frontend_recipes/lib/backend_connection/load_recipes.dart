import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadRecipes {

  /// Fetches a list of [RARecipe] objects from the backend API.
  ///
  /// The method takes three parameters: an [http.Client] instance, a [FirebaseAuth] instance and a [uriEnd] string.
  /// The [http.Client] instance is used to make the HTTP GET request to the API endpoint specified by the [uriEnd] parameter.
  /// The [FirebaseAuth] instance is used to get the current user's ID token, which is added to the request headers for authentication.
  ///
  /// If the HTTP GET request to the API endpoint is successful (status code 200), the response body is decoded from JSON format and mapped to a list of [RARecipe] objects.
  /// The list of [RARecipe] objects is then returned.
  ///
  /// If the HTTP GET request fails, an exception is thrown with the error message 'Failed to load recipes'.
  Future<List<RARecipe>> getRecipes(
      http.Client client, FirebaseAuth auth, String uriEnd) async {
    String uri = 'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/$uriEnd';

    final token = await auth.currentUser!.getIdToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(Uri.parse(uri), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      List<RARecipe> recipes =
          body.map((dynamic item) => RARecipe.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
