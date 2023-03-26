import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Putter {

  ///Set Username in Backend to [newUsername]
  void putUsername(String newUsername) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var request = http.Request('PUT', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user/name'));
    request.body = json.encode({
      "name": newUsername
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}