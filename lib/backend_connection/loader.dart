import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loader {

  Future<String> getUsername() async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request('GET', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user'));
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var response = await streamedResponse.stream.bytesToString();
      dynamic body = jsonDecode(response);
      return body['name'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }

}