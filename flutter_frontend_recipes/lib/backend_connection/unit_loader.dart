import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UnitLoader {
  static late List<String> units;

  factory UnitLoader() => UnitLoader._internal();

  UnitLoader._internal();

  Future<void> init(http.Client client, FirebaseAuth instance) async {
    final response = await client.get(Uri.parse(
        'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/units'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      units = body.map((dynamic item) => unitFromJson(item)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  String unitFromJson(Map<String, dynamic> json) {
    return json['name'];
  }
}
