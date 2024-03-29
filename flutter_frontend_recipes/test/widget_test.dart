import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/content_examples/ingredient_examples.dart';
import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';
import 'package:flutter_frontend_recipes/layout/bottom_navigation_bar_recipe_app.dart';
import 'package:flutter_frontend_recipes/layout/navigation_bar_item.dart';
import 'package:flutter_frontend_recipes/pages/feed/main-page-feed.dart';
import 'package:flutter_frontend_recipes/pages/feed/recipe_card.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/choice_dialog.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/password_dialog.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/password_tile.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_dialog.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_tile.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/widget_tile.dart';
import 'package:flutter_frontend_recipes/pages/profile/main_page_profile.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/allergies.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/app_settings.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/preferences.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_ingredient.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_picture.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/confirm_screen.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_manual.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/ingredient_builder.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/ingredient_list_item.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/name_recipe.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/search_ingredients.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/step_dialog.dart';
import 'package:flutter_frontend_recipes/pages/recipes/last_viewed.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_preview_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/list_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/navigation_switch_recipes.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_preview_exploring.dart';
import 'package:flutter_frontend_recipes/pages/recipes/to_shopping_list_page.dart';
import 'package:flutter_frontend_recipes/pages/recipes/top_navigation_recipes.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/create_shopping_list/add_shopping_list_screen.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/main_page_shopping_lists.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list_item_overview.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list_overview.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list_preview.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/search_bar.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  group('Feed', () {
    testWidgets('Main Page Feed', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: MainFeed()));
      expect(find.text("Willkommen zurück"), findsOneWidget);
      expect(find.text("Zuletzt angesehenes Rezept"), findsOneWidget);
      expect(find.text("Das könnte Ihnen schmecken"), findsOneWidget);
    });

    testWidgets('Recipe Card', (WidgetTester tester) async{
      RARecipe recipe = RARecipe(picture: "assets/example_pictures/standard_picture.jpg", title: "title", description: "description", ingredients: [], manual: []);
      await tester.pumpWidget(MaterialApp(home: RecipeCard(recipe: recipe)));
      await tester.tap(find.text("title"));
      await tester.pumpAndSettle();
    });


  });

  group('App Settings tests', () {
    testWidgets('Allergy page test', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: Allergies()));
      expect(find.text("Nüsse"), findsOneWidget);
      expect(find.text("Eier"), findsOneWidget);
      expect(find.text("Milch"), findsOneWidget);
      expect(find.text("Fisch"), findsOneWidget);
      expect(find.text("Gluten"), findsOneWidget);
      expect(find.text("Meeresfrüchte"), findsOneWidget);
      expect(find.byKey(const Key("NutsSwitch")), findsOneWidget);
      //Define Finders for all Switches
      var findNutsFalse;
      var findNutsTrue;
      var findEggsFalse;
      var findEggsTrue;
      var findMilkFalse;
      var findMilkTrue;
      var findFishFalse;
      var findFishTrue;
      var findGlutenFalse;
      var findGlutenTrue;
      var findSeafoodFalse;
      var findSeafoodTrue;
      List<dynamic> trueFinders = [
        findNutsTrue,
        findEggsTrue,
        findFishTrue,
        findMilkTrue,
        findGlutenTrue,
        findSeafoodTrue
      ];
      List<dynamic> falseFinders = [
        findNutsFalse,
        findEggsFalse,
        findFishFalse,
        findMilkFalse,
        findGlutenFalse,
        findSeafoodFalse
      ];
      List<String> keys = ["NutsSwitch", "EggsSwitch", "MilkSwitch", "FishSwitch", "GlutenSwitch", "SeafoodSwitch"];

      //Check for all Switches if switching on and off works
      for (var i = 0; i < keys.length; i++) {
        trueFinders[i] = find.byWidgetPredicate(
                (widget) =>
            widget is Switch && widget.key == Key(keys[i]) &&
                widget.value == true,
            description: 'Switch is enabled');
        falseFinders[i] = find.byWidgetPredicate(
                (widget) =>
            widget is Switch && widget.key == Key(keys[i]) &&
                widget.value == false,
            description: 'Switch is enabled');
        expect(falseFinders[i], findsOneWidget);
        expect(trueFinders[i], findsNothing);
        await tester.tap(find.byKey(Key(keys[i])));
        await tester.pump();
        expect(trueFinders[i], findsOneWidget);
        expect(falseFinders[i], findsNothing);
        await tester.tap(find.byKey(Key(keys[i])));
        await tester.pump();
        expect(falseFinders[i], findsOneWidget);
        expect(trueFinders[i], findsNothing);
      }
    });

    testWidgets('Preferences Settings test', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: Preferences()));

      //Test if all preferences are displayed
      expect(find.text("Omnivor"), findsOneWidget);
      expect(find.text("Vegetarisch"), findsOneWidget);
      expect(find.text("Vegan"), findsOneWidget);
      expect(find.text("Pescetarisch"), findsOneWidget);

      //Test if all Checkboxes are displayed
      expect(find.byKey(const Key("Omnivor_Checkbox")), findsOneWidget);
      expect(find.byKey(const Key("Vegetarian_Checkbox")), findsOneWidget);
      expect(find.byKey(const Key("Vegan_Checkbox")), findsOneWidget);
      expect(find.byKey(const Key("Pescetarian_Checkbox")), findsOneWidget);

      //Define finders to test values of checkboxes
      final findOmnivorFalse = find.byWidgetPredicate(
              (widget) =>
          widget is Checkbox && widget.key == const Key("Omnivor_Checkbox") &&
              widget.value == false);
      final findVegetarianFalse = find.byWidgetPredicate(
              (widget) =>
          widget is Checkbox &&
              widget.key == const Key("Vegetarian_Checkbox") &&
              widget.value == false);
      final findVeganFalse = find.byWidgetPredicate(
              (widget) =>
          widget is Checkbox && widget.key == const Key("Vegan_Checkbox") &&
              widget.value == false);
      final findPescetarianFalse = find.byWidgetPredicate(
              (widget) =>
          widget is Checkbox &&
              widget.key == const Key("Pescetarian_Checkbox") &&
              widget.value == false);
      final findOmnivorTrue = find.byWidgetPredicate(
              (widget) =>
          widget is Checkbox && widget.key == const Key("Omnivor_Checkbox") &&
              widget.value == true);
      final findVegetarianTrue = find.byWidgetPredicate(
              (widget) =>
          widget is Checkbox &&
              widget.key == const Key("Vegetarian_Checkbox") &&
              widget.value == true);
      final findVeganTrue = find.byWidgetPredicate(
              (widget) =>
          widget is Checkbox && widget.key == const Key("Vegan_Checkbox") &&
              widget.value == true);
      final findPescetarianTrue = find.byWidgetPredicate(
              (widget) =>
          widget is Checkbox &&
              widget.key == const Key("Pescetarian_Checkbox") &&
              widget.value == true);

      // Test if all checkboxes are off by default
      expect(findOmnivorFalse, findsOneWidget);
      expect(findVegetarianFalse, findsOneWidget);
      expect(findVeganFalse, findsOneWidget);
      expect(findPescetarianFalse, findsOneWidget);

      // Test if checking Checkbox for "Omnivor" works and unchecks all other checkboxes
      await tester.tap(find.byKey(const Key("Omnivor_Checkbox")));
      await tester.pump();
      expect(findOmnivorTrue, findsOneWidget);
      for (Finder finder in [
        findVegetarianFalse,
        findVeganFalse,
        findPescetarianFalse
      ]) {
        expect(finder, findsOneWidget);
      }

      // Test if checking Checkbox for "Vegetarian" works and unchecks all other checkboxes
      await tester.tap(find.byKey(const Key("Vegetarian_Checkbox")));
      await tester.pump();
      expect(findVegetarianTrue, findsOneWidget);
      for (Finder finder in [
        findOmnivorFalse,
        findVeganFalse,
        findPescetarianFalse
      ]) {
        expect(finder, findsOneWidget);
      }

      // Test if checking Checkbox for "Vegan" works and unchecks all other checkboxes
      await tester.tap(find.byKey(const Key("Vegan_Checkbox")));
      await tester.pump();
      expect(findVeganTrue, findsOneWidget);
      for (Finder finder in [
        findOmnivorFalse,
        findVegetarianFalse,
        findPescetarianFalse
      ]) {
        expect(finder, findsOneWidget);
      }

      // Test if checking Checkbox for "Pescetarian" works and unchecks all other checkboxes
      await tester.tap(find.byKey(const Key("Pescetarian_Checkbox")));
      await tester.pump();
      expect(findPescetarianTrue, findsOneWidget);
      for (Finder finder in [
        findOmnivorFalse,
        findVeganFalse,
        findVegetarianFalse
      ]) {
        expect(finder, findsOneWidget);
      }
    });

    testWidgets('App Settings', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: AppSettings()));
      expect(find.byType(Switch), findsOneWidget);
    });
  });

  group('Profile components', () {
    testWidgets('Profile Page', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    });

    testWidgets('Choice Dialog Cancel', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: ChoiceDialog(title: "test", values: ["a", "b"], standard: "a", setText: (String value){})));
      await tester.tap(find.text("CANCEL"));
      await tester.pumpAndSettle();
    });

    testWidgets('Choice Dialog OK', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: ChoiceDialog(title: "test", values: ["a", "b"], standard: "a", setText: (String value){})));
      await tester.tap(find.text("b"));
      await tester.pumpAndSettle();
      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();
    });

    testWidgets('Password Dialog OK', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: PasswordDialog(title: "test", setPassword: (String oldStr, String newStr){})));
      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();
    });

    testWidgets('Password Dialog Cancel', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: PasswordDialog(title: "test", setPassword: (String oldStr, String newStr){})));
      await tester.tap(find.text("CANCEL"));
      await tester.pumpAndSettle();
    });

    testWidgets('Password Tile', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: PasswordTile(title: "title", setPassword: (){})));
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
    });

    testWidgets('Text Dialog OK', (WidgetTester tester) async{
      final textCompleter = Completer<String>();
      TextEditingController controller = TextEditingController();
      await tester.pumpWidget(MaterialApp(home: TextDialog(controller: controller, title: "title", setText: textCompleter.complete)));
      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), "a");
      await tester.pumpAndSettle();
      await tester.tap(find.text("OK"));
      expect(textCompleter.isCompleted, isTrue);
    });

    testWidgets('Text Dialog CANCEL', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: TextDialog(controller: TextEditingController(), title: "title", setText: (String str){})));
      await tester.tap(find.text("CANCEL"));
      await tester.pumpAndSettle();
    });

    testWidgets('Text Tile type text', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: TextTile(text: "text", info: "info", type: "text")));
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
    });

    testWidgets('Text Tile type language', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: TextTile(text: "text", info: "info", type: "language")));
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
    });

    testWidgets('Text Tile type country', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: TextTile(text: "text", info: "info", type: "country")));
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
    });

    testWidgets('Text Tile type email', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: TextTile(text: "text", info: "info", type: "email")));
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
    });

    testWidgets('Text Tile type account', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: TextTile(text: "text", info: "info", type: "account")));
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
    });

    testWidgets('Text Tile type data', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: TextTile(text: "text", info: "info", type: "data")));
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
    });

    testWidgets('Widget Tile', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: WidgetTile(text: "text", info: Text("info"))));
    });
  });

  group('create recipe tests', () {
    var backCompleter;
    var nextCompleter;

    Future<void> testCompleter(Completer nextCompleter, Completer backCompleter, WidgetTester tester) async {
      //Test back button
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump();
      expect(backCompleter.isCompleted, isTrue);

      //Test next button
      expect(find.text("Nächster Schritt"), findsOneWidget);
      await tester.tap(find.text("Nächster Schritt"), warnIfMissed: false);
      await tester.pump();
      expect(nextCompleter.isCompleted, isTrue);
    }

    setUp(() {
      backCompleter = Completer<void>();
      nextCompleter = Completer<void>();
    });

    testWidgets('Name Recipe Page test', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      //
      final recipe = RARecipe(picture: '',
          title: '',
          description: '',
          ingredients: [],
          manual: []);

      await tester.pumpWidget(
          MaterialApp(home: NameRecipe(next: nextCompleter.complete, recipe: recipe,)));
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.text("Gib deinem Gericht einen Namen und eine Beschreibung"),
          findsOneWidget);
      expect(find.text("Beschreibung"), findsOneWidget);
      expect(find.text("Rezeptname"), findsOneWidget);

      expect(find.text("Nächster Schritt"), findsOneWidget);
      await tester.tap(find.text("Nächster Schritt"));
      await tester.pump();
      expect(nextCompleter.isCompleted, isTrue);
    });

    testWidgets('add ingredient', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(
        home: AddIngredient(ingredients: [], next: nextCompleter.complete, back: backCompleter.complete, controllers: [], allIngredients: IngredientExamples.ingredients2,),));
      expect(find.text("Füge jetzt die Zutaten hinzu, die du brauchst"), findsOneWidget);
      expect(find.text("Zutaten:"), findsOneWidget);
      expect(find.text("Zutat hinzufügen"), findsOneWidget);
      await testCompleter(nextCompleter, backCompleter, tester);
      await tester.tap(find.text("Zutat hinzufügen"));
      await tester.pump();
      final AddIngredientState myWidgetState = tester.state(find.byType(AddIngredient));
      expect(myWidgetState.lis.isEmpty, isTrue);
      RAIngredient testIngredient = RAIngredient(name: "test", unit: "g", amount: 1, calories: 0);
      myWidgetState.addItem(testIngredient);
      expect(myWidgetState.lis, equals([testIngredient]));
      myWidgetState.removeItem(testIngredient, 0);
      expect(myWidgetState.lis.isEmpty, isTrue);
      expect(myWidgetState.factor, equals(1));
      await tester.enterText(find.byType(TextField), "2");
      expect(myWidgetState.factor, equals(2));
    });

    testWidgets('WillPopScope test', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(
        home: AddIngredient(ingredients: [], next: nextCompleter.complete, back: backCompleter.complete, controllers: [], allIngredients: IngredientExamples.ingredients2,),));
      final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
      expect(await widgetsAppState.didPopRoute(), isTrue);
      expect(backCompleter.isCompleted, isTrue);
    });

    testWidgets('search ingredient', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(MaterialApp(home: SearchIngredients(
          ingredientList: IngredientExamples.ingredients2,
          addItem: (RAIngredient value) {})));
      expect(find.text("Kirschtomaten"), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.text("Kirschtomaten"), warnIfMissed: false);
      await tester.pump();
      expect(find.text("Kirschtomaten hinzufügen"), findsOneWidget);
      expect(find.text("Hinzufügen"), findsOneWidget);
      expect(find.byType(DropdownButtonHideUnderline), findsOneWidget);
      await tester.tap(find.byType(DropdownButtonHideUnderline));
      await tester.pump();
      expect(find.text("g"), findsNWidgets(2));
      await tester.tap(
          find.byType(DropdownButtonHideUnderline), warnIfMissed: false);
      await tester.pump();
      expect(find.text("g"), findsNWidgets(1));
      await tester.tap(find.byType(TextButton));
      await tester.pump();
      expect(find.text("g"), findsNWidgets(0));
    });

    testWidgets('ingredient_list_item', (WidgetTester tester) async {
      RAIngredient ing = RAIngredient(name: "test", unit: "g", amount: 1, calories: 0);
      await tester.pumpWidget(MaterialApp(home: Material(child: IngredientListItem(units: [], controllers: [TextEditingController()], ing: ing, removeItem: (){}, lis: [ing]))));
      expect(find.byType(DropdownButtonHideUnderline), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });
    
    testWidgets('ingredient builder', (WidgetTester tester) async{
      Completer dialogCompleter = Completer<RAIngredient>();
      FlutterError.onError = ignoreOverflowErrors;
      RAIngredient ingredient = RAIngredient(name: "test", unit: "g", amount: 10, calories: 0);
      await tester.pumpWidget(MaterialApp(home: BuildIngredient(ingredient: ingredient, showDialog: dialogCompleter.complete)));
      expect(find.text("test"), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      await tester.pump();
      expect(dialogCompleter.isCompleted, isTrue);
      expect(await dialogCompleter.future, equals(ingredient));
    });

    testWidgets('add manual steps', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(MaterialApp(
        home: CreateManual(manual: [], next: nextCompleter.complete, back: backCompleter.complete),));
      expect(find.text("Verrate uns, wie man dein Rezept zubereitet"),
          findsOneWidget);
      expect(find.text("Neuer Schritt"), findsOneWidget);
      await tester.tap(find.text("Neuer Schritt"));
      await tester.pump();
      expect(find.text("Speichern"), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(StepDialog), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Schritt 1');
      await tester.tap(find.text("Speichern"));
      await tester.pump();
      expect(find.text('1.Schritt 1'), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pump();
      expect(find.text('Schritt 1'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Neu');
      await tester.tap(find.text("Speichern"));
      await tester.pump();
      expect(find.text('1.Neu'), findsOneWidget);
      expect(find.text('1.Schritt 1'), findsNothing);
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      expect(find.byIcon(Icons.close), findsNothing);
      expect(find.text('1.Neu'), findsNothing);
      await testCompleter(nextCompleter, backCompleter, tester);
    });

    testWidgets('choose recipe picture', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(MaterialApp(home: AddPicture(
        next: nextCompleter.complete, back: backCompleter.complete, setPicture: (String picture) {},),));
      expect(find.text("Wie sieht dein Gericht aus?"), findsOneWidget);
      expect(find.text("Füge jetzt ein Foto hinzu"), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      await testCompleter(nextCompleter, backCompleter, tester);
      await tester.tap(find.text("Foto auswählen"));
      await tester.pump();
      expect(find.text("Galerie"), findsOneWidget);
      expect(find.text("Kamera"), findsOneWidget);
      expect(find.byIcon(Icons.collections), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
      await tester.tap(find.byIcon(Icons.collections), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.camera_alt), warnIfMissed: false);
      await tester.pumpAndSettle();
    });

    testWidgets('confirm screen', (WidgetTester tester) async{
      final uploadCompleter = Completer<void>();
      await tester.pumpWidget(MaterialApp(home: ConfirmRecipe(upload: uploadCompleter.complete)));
      await tester.tap(find.text("Zurück"));
      await tester.pumpAndSettle();
      expect(uploadCompleter.isCompleted, isTrue);
    });
  });

  group('recipe overview tests', () {

    test('Last Viewed', () {
      LastViewed _lastviewed = LastViewed();
      _lastviewed.recipe = RecipeExamples.testRecipe2;

    });

    testWidgets('Recipe List Preview', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: Material(child: RecipeAppRecipeListPreview(title: "title", numberRecipes: 1, recipes: [RecipeExamples.testRecipe1]))));
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
    });

    testWidgets('List Recipes', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: ListRecipes(recipes: [RecipeExamples.testRecipe1], title: "")));
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
    });

    testWidgets('Navigation Switch Recipes', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: RecipeAppNavigationSwitchRecipes(onChange: (int index){}, selectedIndex: 0)));
      await tester.tap(find.byKey(Key("Detector 1")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Detector 0")));
      await tester.pumpAndSettle();
    });

    testWidgets('Recipe Overview', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      RARecipe recipe = RARecipe(picture: 'assets/example_pictures/hamburger.jpg', title: "title", description: "description", ingredients: IngredientExamples.ingredients2, manual: ["manual"], tags: ["tag1"], time: 1, difficulty: "test");
      await tester.pumpWidget(MaterialApp(home: RecipeOverview(recipe: recipe)));
      await tester.dragUntilVisible(find.text("Zu Einkaufslisten hinzufügen"), find.byType(ListView), const Offset(0, -500));
      await tester.tap(find.text("Zu Einkaufslisten hinzufügen"));
      await tester.pumpAndSettle();
    });

    testWidgets('Recipe Preview Exploring All Recipes', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      RARecipe recipe = RARecipe(picture: 'assets/example_pictures/hamburger.jpg', title: "title", description: "description", ingredients: IngredientExamples.ingredients2, manual: ["manual"], tags: ["tag1"], time: 1, difficulty: "test");
      await tester.pumpWidget(MaterialApp(home: Material(child: RecipeAppRecipePreviewExploring(recipe: recipe, own: false, search: false))));
      await tester.tap(find.byKey(const Key("StarInkWell")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("OverviewDetector")));
      await tester.pumpAndSettle();
    });

    testWidgets('To old Shopping List', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({"shoppinglist_testlist" : jsonEncode(RAShoppingList(title: "testlist", creationDate: DateTime(2017, 9, 7, 17, 30)))});
      await SharedPrefs().init();
      RARecipe recipe = RARecipe(picture: 'assets/example_pictures/hamburger.jpg', title: "title", description: "description", ingredients: IngredientExamples.ingredients2, manual: ["manual"], tags: ["tag1"], time: 1, difficulty: "test");
      await tester.pumpWidget(MaterialApp(home: ToShoppingList(recipe: recipe)));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.text("Zu bestender Liste hinzufügen"));
      await tester.pump();
      expect(find.text("Bestehende Einkaufslisten"), findsOneWidget);
      expect(find.text("testlist"), findsOneWidget);
      await tester.tap(find.text("testlist"));
      await tester.pumpAndSettle();
    });

    testWidgets('To new Shopping List', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      RARecipe recipe = RARecipe(picture: 'assets/example_pictures/hamburger.jpg', title: "title", description: "description", ingredients: IngredientExamples.ingredients2, manual: ["manual"], tags: ["tag1"], time: 1, difficulty: "test");
      await tester.pumpWidget(MaterialApp(home: ToShoppingList(recipe: recipe)));
      await tester.tap(find.byKey(Key("Plus Button")));
      await tester.pump();
      await tester.longPress(find.byKey(Key("Plus Button")));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.text("Neue Liste erstellen"));
      await tester.pump();
    });

    testWidgets('Top Navigation', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: Material(child: RecipeAppTopNavigation(onChange: (){}, selectedIndex: 0, onSearch: (){}, onFilter: (){}, choice: "choice"))));
    });
  });

  group('Shopping Lists', () {

    testWidgets('Add Shoppinglist Screen', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: AddShoppingListScreen()));
      await tester.tap(find.byType(RAButton));
      await tester.pump();
      await tester.enterText(find.byType(RAInputField), "title");
      await tester.pump();
      await tester.tap(find.byType(RAButton));
      await tester.pump();
    });

    testWidgets('Add Shoppinglist Screen extra tests', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: AddShoppingListScreen()));
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump();
      final AddShoppingListScreenState myWidgetState = tester.state(find.byType(AddShoppingListScreen));
      myWidgetState.titleMissing = true;
      expect(myWidgetState.titleMissing, isTrue);
      myWidgetState.resetTitleMissing();
      expect(myWidgetState.titleMissing, isFalse);
    });

    testWidgets('Empty Shoppinglist Main Page', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: NewMainPageShoppingLists()));
    });

    testWidgets('Not Empty Shoppinglist Main Page', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({"shoppinglist_testlist" : jsonEncode(RAShoppingList(title: "testlist", creationDate: DateTime(2017, 9, 7, 17, 30)))});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: NewMainPageShoppingLists()));
      await tester.tap(find.text("Einkaufsliste erstellen"));
      await tester.pump();
    });

    testWidgets('Shopping List Item Overview long press', (WidgetTester tester) async{
      RAIngredient ing = RAIngredient(name: "name", unit: "g", amount: 1, calories: 0);
      await tester.pumpWidget(MaterialApp(home: Material(child: RAShoppingListItemOverview(item: ing, updateShoppingListIngredientDone: (){}, onLongPress: (){}))));
      await tester.longPress(find.byKey(const Key("LongPressDetector")));
      await tester.pumpAndSettle();
    });

    testWidgets('Shopping List Item Overview', (WidgetTester tester) async{
      RAIngredient ing = RAIngredient(name: "name", unit: "g", amount: 1, calories: 0);
      await tester.pumpWidget(MaterialApp(home: Material(child: RAShoppingListItemOverview(item: ing, updateShoppingListIngredientDone: (RAIngredient ing){}, onLongPress: (){}))));
      await tester.tap(find.byKey(const Key("ShoppingListsItemDoneButtonIcon")));
    });

    testWidgets('Shopping List Item Overview with ingredient from recipe', (WidgetTester tester) async{
      RAIngredient ing = RAIngredient(name: "name", unit: "g", amount: 1, calories: 0, recipe: RecipeExamples.testRecipe1);
      await tester.pumpWidget(MaterialApp(home: Material(child: RAShoppingListItemOverview(item: ing, updateShoppingListIngredientDone: (RAIngredient ing){}, onLongPress: (){}))));
      await tester.tap(find.byKey(const Key("RecipeLink")));
      await tester.pump();
    });

    testWidgets('Empty Shopping List Overview', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: RAShoppingListOverview(shoppingList: RAShoppingList(title: "title", creationDate: DateTime(2023)))));
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump();
    });

    testWidgets('Delete Shopping List', (WidgetTester tester) async{
      SharedPreferences.setMockInitialValues({});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: RAShoppingListOverview(shoppingList: RAShoppingList(title: "title", creationDate: DateTime(2023)))));
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();
      await tester.tap(find.text("abbrechen"));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();
      await tester.tap(find.text("löschen"));
      await tester.pump();
    });

    testWidgets('Edit Shopping List', (WidgetTester tester) async{
      RAShoppingList list = RAShoppingList(title: "title", creationDate: DateTime(2023), items: [RAIngredient(name: "name", unit: "unit", amount: 1, calories: 0)]);
      SharedPreferences.setMockInitialValues({"shoppinglist_title" : jsonEncode(list)});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: RAShoppingListOverview(shoppingList: list)));
      expect(find.text("name"), findsOneWidget);
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pump();
      await tester.tap(find.text("abbrechen"));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pump();
      await tester.enterText(find.byKey(const Key("EditingDialouge")), "newtitle");
      await tester.pump();
      await tester.tap(find.text("ok"));
      await tester.pump();
    });

    testWidgets('Add item to Shopping List', (WidgetTester tester) async{
      RAShoppingList list = RAShoppingList(title: "title", creationDate: DateTime(2023), items: [RAIngredient(name: "name", unit: "unit", amount: 1, calories: 0)]);
      SharedPreferences.setMockInitialValues({"shoppinglist_title" : jsonEncode(list)});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: RAShoppingListOverview(shoppingList: list)));
      await tester.tap(find.text("Sache hinzufügen"));
      await tester.pump();
      await tester.tap(find.text("abbrechen"));
      await tester.pump();
      await tester.tap(find.text("Sache hinzufügen"));
      await tester.pump();
      await tester.tap(find.text("ok"));
      await tester.pump();
      await tester.tap(find.text("Sache hinzufügen"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("NewItemName")), "itemname");
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("NewItemAmount")), "1");
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("NewItemUnit")), "g");
      await tester.pumpAndSettle();
      await tester.tap(find.text("ok"));
      await tester.pump();
    });

    testWidgets('Edit Shopping List item', (WidgetTester tester) async{
      RAShoppingList list = RAShoppingList(title: "title", creationDate: DateTime(2023), items: [RAIngredient(name: "name", unit: "unit", amount: 1, calories: 0)]);
      SharedPreferences.setMockInitialValues({"shoppinglist_title" : jsonEncode(list)});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: RAShoppingListOverview(shoppingList: list)));
      await tester.longPress(find.text("name"));
      await tester.pumpAndSettle();
      await tester.tap(find.text("abbrechen"));
      await tester.pumpAndSettle();
      await tester.longPress(find.text("name"));
      await tester.pumpAndSettle();
      await tester.longPress(find.text("ok"));
      await tester.pumpAndSettle();
    });

    testWidgets('Dismiss/Delete Shopping List item', (WidgetTester tester) async{
      RAShoppingList list = RAShoppingList(title: "title", creationDate: DateTime(2023), items: [RAIngredient(name: "name", unit: "unit", amount: 1, calories: 0)]);
      SharedPreferences.setMockInitialValues({"shoppinglist_title" : jsonEncode(list)});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: RAShoppingListOverview(shoppingList: list)));
      await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();
    });

    testWidgets('ShoppingListPreview 1 Gegenstand', (WidgetTester tester) async{
      RAShoppingList list = RAShoppingList(title: "title", creationDate: DateTime(2023), items: [RAIngredient(name: "name", unit: "unit", amount: 1, calories: 0)]);
      SharedPreferences.setMockInitialValues({"shoppinglist_title" : jsonEncode(list)});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: Material(child: ShoppingListPreview(shoppingList: list, reLoadRecipes: (){}))));
      await tester.tap(find.byKey(const Key("ShoppingListsFavoriteButton")));
      await tester.pump();
      await tester.tap(find.byKey(const Key("ShoppingListDetector")));
      await tester.pumpAndSettle();
    });

    testWidgets('ShoppingListPreview 2 Gegenstände', (WidgetTester tester) async{
      RAShoppingList list = RAShoppingList(title: "title", creationDate: DateTime(2023), items: [RAIngredient(name: "name1", unit: "unit", amount: 1, calories: 0), RAIngredient(name: "name2", unit: "unit", amount: 1, calories: 0)]);
      SharedPreferences.setMockInitialValues({"shoppinglist_title" : jsonEncode(list)});
      await SharedPrefs().init();
      await tester.pumpWidget(MaterialApp(home: Material(child: ShoppingListPreview(shoppingList: list, reLoadRecipes: (){}))));
    });
  });

  group('Layout', () {
    testWidgets("NavigationBarItem", (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: NavigationBarItem(icon: Icons.home, isSelected: true, onPressed: (){})));
    });

    testWidgets("NavigationBar", (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: BottomNavigationBarRecipeApp(onChange: (int index){}, selectedIndex: 0)));
      await tester.tap(find.byKey(const Key("FeedNavigation")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("RecipeNavigation")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("ShoppingNavigation")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("ProfileNavigation")));
      await tester.pumpAndSettle();
    });

  });

  group('Shared', () {
    testWidgets("Shared Button with Icon", (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: RAButton(onTap: (){}, description: "description", icon: Icons.add, iconColor: Colors.black,)));
      await tester.pumpAndSettle();
    });

    testWidgets("Shared Input Field", (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: Material(child: RAInputField(hintText: "hintText", controller: TextEditingController()))));
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
    });

    testWidgets("Shared Input Password Field", (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: Material(child: RAInputField(hintText: "hintText", controller: TextEditingController(), isPassword: true))));
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
    });

    testWidgets("Shared Search Bar", (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: Material(child: RecipeAppSearchBar(onSearch: (){}, onFilter: (){}, choice: ""))));
      await tester.tap(find.byIcon(Icons.filter_alt_outlined));
      await tester.pumpAndSettle();
      expect(find.text("Filter"), findsOneWidget);
    });

  });
}


void ignoreOverflowErrors(FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  bool ifIsOverflowError = false;
  bool isUnableToLoadAsset = false;

  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
          (e) => e.value.toString().startsWith("A RenderFlex overflowed by"),
    );
    isUnableToLoadAsset = !exception.diagnostics.any(
          (e) => e.value.toString().startsWith("Unable to load asset"),
    );
  }


  // Ignore if is overflow error.
  if (ifIsOverflowError || isUnableToLoadAsset) {
    debugPrint('Ignored Error');
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }
}
