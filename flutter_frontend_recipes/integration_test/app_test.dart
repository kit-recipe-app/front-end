import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_frontend_recipes/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("integration tests", () {
    testWidgets("login", (tester) async {
/*        final auth = MockFirebaseAuth();
        auth.signInAnonymously();*/
      app.main();
      await tester.pump(const Duration(seconds: 5));
      expect(find.byKey(const Key("Login")), findsOneWidget);
      expect(find.byKey(const Key("EmailInput")), findsOneWidget);
      expect(find.byKey(const Key("PasswordInput")), findsOneWidget);
      await tester.enterText(find.byKey(const Key("EmailInput")), 'test');
      await tester.pump(const Duration(seconds: 1));
      await tester.enterText(find.byKey(const Key("PasswordInput")), 'test');
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key("LoginButton")));
      await tester.pump(const Duration(seconds: 2));
      expect(
          find.text("The email address is badly formatted."), findsOneWidget);
      await tester.enterText(
          find.byKey(const Key("EmailInput")), 'abc@test.de');
      await tester.enterText(find.byKey(const Key("PasswordInput")), 'test');
      await tester.tap(find.byKey(const Key("LoginButton")));
      await tester.pump(const Duration(seconds: 2));
      expect(
          find.text(
              "There is no user record corresponding to this identifier. The user may have been deleted."),
          findsOneWidget);
      await tester.enterText(
          find.byKey(const Key("EmailInput")), 'testnutzer@tes.de');
      await tester.enterText(
          find.byKey(const Key("PasswordInput")), '12345678');
      await tester.tap(find.byKey(const Key("LoginButton")));
      await tester.pump(const Duration(seconds: 2));
      expect(find.byKey(const Key("MainFeedPage")), findsOneWidget);
    });

    testWidgets("navigate between screens", (tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 5));
      expect(find.byKey(const Key("MainFeedPage")), findsOneWidget);
      expect(find.byKey(const Key("FeedNavigation")), findsOneWidget);
      expect(find.byKey(const Key("RecipeNavigation")), findsOneWidget);
      expect(find.byKey(const Key("ShoppingNavigation")), findsOneWidget);
      expect(find.byKey(const Key("ProfileNavigation")), findsOneWidget);

      await tester.tap(find.byKey(const Key("RecipeNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("RecipePage")), findsOneWidget);

      await tester.tap(find.byKey(const Key("ShoppingNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("ShoppingListsPage")), findsOneWidget);

      await tester.tap(find.byKey(const Key("ProfileNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("ProfilePage")), findsOneWidget);

      await tester.tap(find.byKey(const Key("FeedNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("MainFeedPage")), findsOneWidget);
    });

    testWidgets("create shopping-list with item", (tester) async {
      String testListName = "Test-Liste";
      String testItemName = "Banane";
      String testItemAmount = "5";
      String testItemUnit = "Stück";
      app.main();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));

      await tester.tap(find.byKey(const Key("ShoppingNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("ShoppingListsPage")), findsOneWidget);

      await tester.tap(find.byKey(const Key("createShoppingListButton")));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byKey(const Key("AddShoppingListPage")), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("NewShoppingListTitleInput")), testListName);
      await tester.tap(find.byKey(const Key("NewShoppingListSaveButton")));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byKey(Key("$testListName Preview")), findsOneWidget);

      await tester.tap(find.byKey(Key("$testListName Preview")));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byKey(Key("$testListName Overview")), findsOneWidget);

      await tester.tap(find.byKey(const Key("AddItemToShoppingListButton")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("ItemAddDialogue")), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("NewItemName")), testItemName);
      await tester.enterText(
          find.byKey(const Key("NewItemAmount")), testItemAmount);
      await tester.enterText(
          find.byKey(const Key("NewItemUnit")), testItemUnit);
      await tester.tap(find.byKey(const Key("AddItemConfirmButton")));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byKey(Key("$testItemName $testItemAmount $testItemUnit")),
          findsOneWidget);
    });
  });
}
