import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;


class Deleter{

  /// Sends a DELETE HTTP request to the backend API to delete the recipe with the given [id].
  ///
  /// The [id] parameter is a string that represents the ID of the recipe to be deleted.
  ///
  /// The method first gets the ID token of the current user from the `FirebaseAuth` instance and adds it to the HTTP request headers.
  /// It then creates an HTTP DELETE request with the specified [id] and headers and sends the request.
  static void deleteRecipe(String id) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var request = http.Request('DELETE', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user/recipes/$id'));

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