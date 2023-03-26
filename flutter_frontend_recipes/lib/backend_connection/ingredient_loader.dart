import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../content_examples/ingredient_examples.dart';
import '../types/ingredient.dart';

class IngredientLoader {
  static late List<RAIngredient> ingredients;

  factory IngredientLoader() => IngredientLoader._internal();

  IngredientLoader._internal();

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