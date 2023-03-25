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
      await tester.pump(Duration(seconds: 5));
      expect(find.byKey(Key("Login")), findsOneWidget);
      expect(find.byKey(Key("EmailInput")), findsOneWidget);
      expect(find.byKey(Key("PasswordInput")), findsOneWidget);
      await tester.enterText(find.byKey(Key("EmailInput")), 'test');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(find.byKey(Key("PasswordInput")), 'test');
      await tester.tap(find.byKey(Key("LoginButton")));
      await tester.pump(Duration(seconds: 2));
      expect(find.text("The email address is badly formatted."), findsOneWidget);
      await tester.enterText(find.byKey(Key("EmailInput")), 'abc@test.de');
      await tester.enterText(find.byKey(Key("PasswordInput")), 'test');
      await tester.tap(find.byKey(Key("LoginButton")));
      await tester.pump(Duration(seconds: 2));
      expect(find.text("There is no user record corresponding to this identifier. The user may have been deleted."), findsOneWidget);
      await tester.enterText(find.byKey(Key("EmailInput")), 'testnutzer@tes.de');
      await tester.enterText(find.byKey(Key("PasswordInput")), '12345678');
      await tester.tap(find.byKey(Key("LoginButton")));
      await tester.pump(Duration(seconds: 2));
      expect(find.byKey(const Key("MainFeedPage")), findsOneWidget);
    });

    testWidgets("navigate between screens", (tester) async{
      app.main();
      await tester.pump(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 5));
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
  });
}
