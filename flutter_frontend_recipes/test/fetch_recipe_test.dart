import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_frontend_recipes/backend_connection/load_recipes.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'fetch_recipe_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client],)
void main() {
  group('fetchRecipe', (){
    test('returns a Recipe if the http call completes successfully', () async{
      final client = MockClient();
      final loader = LoadRecipes();
      final auth = MockFirebaseAuth();
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      auth.signInAnonymously();
      when(client
          .get(Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user/recipes'), headers: anyNamed('headers')))
          .thenAnswer((_) async =>
          http.Response('[{"name":"Recipe1","id":"1","description":"Recipe1 description","imageData":null,"ingredients":[{"amountInformation":{"unit":{"name":"g"},"amount":20.0},"ingredient":{"name":"Kirschtomaten"}}],"cookingInstructions":[{"instruction":"cook slowly"}]},{"name":"Recipe2","id":"2","description":"recipe 2 description","imageData":null,"ingredients":[{"amountInformation":{"unit":{"name":"g"},"amount":20.0},"ingredient":{"name":"Kirschtomaten"}}],"cookingInstructions":[{"instruction":"cook with fire"}]}]', 200));
      final recipes = await loader.getRecipes(client, auth);
      expect(recipes, isA<List<RARecipe>>());
      expect(recipes.length, equals(2));
      expect(recipes[0].title, equals("Recipe1"));
      expect(recipes[0].description, equals("Recipe1 description"));

    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final auth = MockFirebaseAuth();
      auth.signInAnonymously();
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
          .get(Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user/recipes'), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(LoadRecipes().getRecipes(client, auth), throwsException);
    });

  });
}