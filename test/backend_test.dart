import 'package:flutter_frontend_recipes/backend_connection/ingredient_loader.dart';
import 'package:flutter_frontend_recipes/content_examples/ingredient_examples.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_frontend_recipes/backend_connection/load_recipes.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'backend_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks(
  [http.Client],
)
void main() {
  group('fetchRecipe', () {
    test('returns a Recipe if the http call completes successfully', () async {
      final client = MockClient();
      final loader = LoadRecipes();
      final auth = MockFirebaseAuth();
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      auth.signInAnonymously();
      //own recipes
      when(client.get(
              Uri.parse(
                  'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user/recipes'),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '[{"name":"Recipe1","id":"1","description":"Recipe1 description","imageData":null,"ingredients":[{"amountInformation":{"unit":{"name":"g"},"amount":20.0},"ingredient":{"name":"Kirschtomaten"}}],"cookingInstructions":[{"instruction":"cook slowly"}]},{"name":"Recipe2","id":"2","description":"recipe 2 description","imageData":null,"ingredients":[{"amountInformation":{"unit":{"name":"g"},"amount":20.0},"ingredient":{"name":"Kirschtomaten"}}],"cookingInstructions":[{"instruction":"cook with fire"}]}]',
              200));
      final recipes = await loader.getRecipes(client, auth, false);
      expect(recipes, isA<List<RARecipe>>());
      expect(recipes.length, equals(2));
      expect(recipes[0].title, equals("Recipe1"));
      expect(recipes[0].description, equals("Recipe1 description"));
      //all recipes
      when(client.get(
              Uri.parse(
                  'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes'),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '[{"name":"AllRecipe1","id":"1","description":"AllRecipe1 description","imageData":null,"ingredients":[{"amountInformation":{"unit":{"name":"g"},"amount":20.0},"ingredient":{"name":"Kirschtomaten"}}],"cookingInstructions":[{"instruction":"cook slowly"}]},{"name":"AllRecipe2","id":"2","description":"AllRecipe 2 description","imageData":null,"ingredients":[{"amountInformation":{"unit":{"name":"g"},"amount":20.0},"ingredient":{"name":"Kirschtomaten"}}],"cookingInstructions":[{"instruction":"cook with fire"}]}]',
              200));
      final allRecipes = await loader.getRecipes(client, auth, true);
      expect(allRecipes, isA<List<RARecipe>>());
      expect(allRecipes.length, equals(2));
      expect(allRecipes[0].title, equals("AllRecipe1"));
      expect(allRecipes[0].description, equals("AllRecipe1 description"));
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final auth = MockFirebaseAuth();
      auth.signInAnonymously();
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse(
                  'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user/recipes'),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      when(client.get(
          Uri.parse(
              'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes'),
          headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(LoadRecipes().getRecipes(client, auth, false), throwsException);
      expect(LoadRecipes().getRecipes(client, auth, true), throwsException);
    });
  });

  test('load Ingredients', () async {
    final client = MockClient();
    final auth = MockFirebaseAuth();
    IngredientLoader().init(client, auth);
    expect(IngredientLoader.ingredients, IngredientExamples.ingredients2);
    auth.signInAnonymously();
    when(client.get(
        Uri.parse(
            'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/ingredients'),
        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(
      '[{"id": "ab56bde1-e33d-4c0e-8a4a-264a531d7fbd", "name": "Lachs", "tag": "null"}]',
        200));
    await IngredientLoader().init(client, auth);
    expect(IngredientLoader.ingredients.length, equals(1));
  });

  test('load Ingredients throws exception if http call returns error', () async {
    final client = MockClient();
    final auth = MockFirebaseAuth();
    auth.signInAnonymously();
    when(client.get(
        Uri.parse(
            'https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/ingredients'),
        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Not Found', 404));
    expect(IngredientLoader().init(client, auth), throwsException);
  });
}
