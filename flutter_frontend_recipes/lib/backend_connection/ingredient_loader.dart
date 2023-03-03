import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../types/ingredient.dart';

class IngredientLoader {
  static late List<RAIngredient> ingredients;

  factory IngredientLoader() => IngredientLoader._internal();

  IngredientLoader._internal();

  Future<void> init() async{
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request('GET', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/ingredients'));
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      var response = await streamedResponse.stream.bytesToString();
      print(response);
      List<dynamic> body = jsonDecode(response);
      ingredients = body.map((dynamic item) => RAIngredient.fromJsonBackend(item)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }


  }



}