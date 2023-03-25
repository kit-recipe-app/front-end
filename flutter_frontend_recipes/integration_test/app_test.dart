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

      String validTestUserName = "testnutzer@tes.de";
      String validTestUserPassword = "12345678";
      app.main();
      await tester.pump(const Duration(seconds: 5));
      expect(find.byKey(const Key("Login")), findsOneWidget);
      expect(find.byKey(const Key("EmailInput")), findsOneWidget);
      expect(find.byKey(const Key("PasswordInput")), findsOneWidget);
      await tester.enterText(find.byKey(const Key("EmailInput")), 'test');
      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(find.byKey(const Key("PasswordInput")), 'test');
      await tester.pump(const Duration(seconds: 2));
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
          find.byKey(const Key("EmailInput")), validTestUserName);
      await tester.enterText(
          find.byKey(const Key("PasswordInput")), validTestUserPassword);
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
      // test data
      String testListName = "Test-List";
      String testItemName = "Banane";
      String testItemAmount = "5";
      String testItemUnit = "Stück";

      // start app and give time to settle
      app.main();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));

      // navigate to shopping-list-page and check if correct page is shown
      await tester.tap(find.byKey(const Key("ShoppingNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("ShoppingListsPage")), findsOneWidget);

      // click create-shoppping-list button and check if correct page is shown
      await tester.tap(find.byKey(const Key("createShoppingListButton")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("AddShoppingListPage")), findsOneWidget);

      // enter shopping-list title, save and check if stored
      await tester.enterText(
          find.byKey(const Key("NewShoppingListTitleInput")), testListName);
      await tester.tap(find.byKey(const Key("NewShoppingListSaveButton")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(Key("$testListName Preview")), findsOneWidget);

      // navigate to test-list-overview and check if correct widget is shown
      await tester.tap(find.byKey(Key("$testListName Preview")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(Key("$testListName Overview")), findsOneWidget);

      // click add-item-button and check if correct dialoguer is showed
      await tester.tap(find.byKey(const Key("AddItemToShoppingListButton")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("ItemAddDialogue")), findsOneWidget);

      // enter data for new item, save if and check if stored
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

      // navigate back to main-feed-page
      await tester.tap(find.byKey(const Key("BackButtonShoppingListOverview")));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key("FeedNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("MainFeedPage")), findsOneWidget);
    });

    testWidgets(
        "favorite shopping-lists and mark items done (shared-prefs-test)",
        (tester) async {
      String testListName = "Test-List";

      // start app and give time to settle
      app.main();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));

      // navigate to shopping-lists and check if non-favorite-list found
      await tester.tap(find.byKey(const Key("ShoppingNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(
          find
              .byKey(const Key("ShoppingListsFavoriteButtonIcon"))
              .evaluate()
              .single
              .widget
              .toString(),
          const Icon(
            key: Key("ShoppingListsFavoriteButtonIcon"),
            Icons.star_border,
            color: Colors.yellow,
          ).toString());

      // click favorite-button and check if then favorite
      await tester.tap(find.byKey(const Key("ShoppingListsFavoriteButton")));
      await tester.pump(const Duration(seconds: 1));
      expect(
          find
              .byKey(const Key("ShoppingListsFavoriteButtonIcon"))
              .evaluate()
              .single
              .widget
              .toString(),
          const Icon(
            key: Key("ShoppingListsFavoriteButtonIcon"),
            Icons.star,
            color: Colors.yellow,
          ).toString());

      // open shopping-list-overview, and check if non-done-item found
      await tester.tap(find.byKey(Key("$testListName Preview")));
      await tester.pump(const Duration(seconds: 1));
      expect(
          find
              .byKey(const Key("ShoppingListsItemDoneButtonIcon"))
              .evaluate()
              .single
              .widget
              .toString(),
          const Icon(
            key: Key("ShoppingListsItemDoneButtonIcon"),
            Icons.check_box_outline_blank,
          ).toString());

      // click done-button and check if then done
      await tester.tap(find.byKey(const Key("ShoppingListsItemDoneButton")));
      await tester.pump(const Duration(seconds: 1));
      expect(
          find
              .byKey(const Key("ShoppingListsItemDoneButtonIcon"))
              .evaluate()
              .single
              .widget
              .toString(),
          const Icon(
            key: Key("ShoppingListsItemDoneButtonIcon"),
            Icons.check_box,
          ).toString());

      // switch screen to make sure favorite and done info is not stored only in widget
      await tester.tap(find.byKey(const Key("BackButtonShoppingListOverview")));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key("FeedNavigation")));
      await tester.pump(const Duration(seconds: 5));
      await tester.tap(find.byKey(const Key("ShoppingNavigation")));
      await tester.pump(const Duration(seconds: 1));

      // check if list is still favorite
      expect(
          find
              .byKey(const Key("ShoppingListsFavoriteButtonIcon"))
              .evaluate()
              .single
              .widget
              .toString(),
          const Icon(
            key: Key("ShoppingListsFavoriteButtonIcon"),
            Icons.star,
            color: Colors.yellow,
          ).toString());

      // open shopping-list-overview, and check if item is still done
      await tester.tap(find.byKey(Key("$testListName Preview")));
      await tester.pump(const Duration(seconds: 1));
      expect(
          find
              .byKey(const Key("ShoppingListsItemDoneButtonIcon"))
              .evaluate()
              .single
              .widget
              .toString(),
          const Icon(
            key: Key("ShoppingListsItemDoneButtonIcon"),
            Icons.check_box,
          ).toString());

      // navigate back to main-feed-page
      await tester.tap(find.byKey(const Key("BackButtonShoppingListOverview")));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key("FeedNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("MainFeedPage")), findsOneWidget);
    });

    testWidgets("navigate through login-page", (tester) async {

      // start app and give time to settle
      app.main();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));

      // navigate to profile page and check if all buttons are present
      await tester.tap(find.byKey(const Key("ProfileNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("ProfilePreviewButton")), findsOneWidget);
      expect(
          find.byKey(const Key("SettingsButtonEinstellungen")), findsOneWidget);
      expect(
          find.byKey(const Key("SettingsButtonPräferenzen")), findsOneWidget);
      expect(find.byKey(const Key("SettingsButtonAllergien")), findsOneWidget);

      // click on all buttons and check if they work correct
      await tester.tap(find.byKey(const Key("ProfilePreviewButton")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("AccountSettings")), findsOneWidget);
      await tester.tap(find.byKey(const Key("BackButton")));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("SettingsButtonEinstellungen")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("SettingsPage")), findsOneWidget);
      await tester.tap(find.byKey(const Key("BackButton")));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("SettingsButtonPräferenzen")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("PreferencesPage")), findsOneWidget);
      await tester.tap(find.byKey(const Key("BackButton")));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("SettingsButtonAllergien")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("AllergiesPage")), findsOneWidget);
      await tester.tap(find.byKey(const Key("BackButton")));
      await tester.pump(const Duration(seconds: 1));


      // navigate back to main-feed-page
      await tester.tap(find.byKey(const Key("FeedNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("MainFeedPage")), findsOneWidget);
    });

    testWidgets("navigate through recipes", (tester) async {

    });

    testWidgets("log out", (tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));

      //expect(find.byKey(Key("ProfileNavigation")), findsOneWidget);
      await tester.tap(find.byKey(const Key("ProfileNavigation")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("ProfilePage")), findsOneWidget);

      await tester.tap(find.byKey(const Key("SignOutButton")));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key("LoginPage")), findsOneWidget);
    });
  });
}
