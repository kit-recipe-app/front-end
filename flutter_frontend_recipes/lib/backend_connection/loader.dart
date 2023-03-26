import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loader {

  /// Fetches the current user's username from the backend API.
  ///
  /// The method makes an HTTP GET request to the '/api/v1/user' endpoint of the backend API to get the current user's details.
  /// The current user's ID token is added to the request headers for authentication.
  ///
  /// If the HTTP GET request to the API endpoint is successful (status code 200), the response body is decoded from JSON format.
  /// The username is extracted from the response body and returned as a string.
  ///
  /// If the HTTP GET request fails, an exception is thrown with the error message 'Failed to load username'.
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
      throw Exception('Failed to load username');
    }
  }

}
