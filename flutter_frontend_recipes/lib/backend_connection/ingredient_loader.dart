import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../types/ingredient.dart';

class IngredientLoader {

  // static list of ingredients
  static late List<RAIngredient> ingredients;

  // private constructor to ensure only one instance of the class can be created
  factory IngredientLoader() => IngredientLoader._internal();

  // factory constructor to create a new instance of the class
  IngredientLoader._internal();

  /// Initializes the ingredients list by fetching data from the backend API.
  ///
  /// The [client] parameter is an instance of the `http.Client` class that is used to make HTTP requests.
  /// The [instance] parameter is an instance of the `FirebaseAuth` class that is used to get the current user's ID token.
  ///
  /// Is used to fetch the list of ingredients from the backend API.
  ///
  /// Throws an [Exception] if the API request fails.
  Future<void> init(http.Client client, FirebaseAuth instance) async{
    /*
    if(instance.currentUser == null){
      ingredients = IngredientExamples.ingredients2;
      return ;
    }
    var token = await instance.currentUser!.getIdToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    */
    final response = await client.get(Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/ingredients')/*, headers: headers*/);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      ingredients = body.map((dynamic item) => RAIngredient.fromJsonBackend(item)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }


  }

}