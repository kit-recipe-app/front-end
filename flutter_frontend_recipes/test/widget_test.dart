import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/content_examples/ingredient_examples.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/allergies.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/preferences.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_ingredient.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_picture.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_manual.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/ingredient_builder.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/name_recipe.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/search_ingredients.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/step_dialog.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('create recipe widget tests', () {
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
      await tester.tap(find.text("Nächster Schritt"));
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
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(MaterialApp(
        home: AddIngredient(ingredients: [], next: nextCompleter.complete, back: backCompleter.complete, controllers: [],),));
      expect(find.text("Füge jetzt die Zutaten hinzu, die du brauchst"), findsOneWidget);
      expect(find.text("Zutaten:"), findsOneWidget);
      testCompleter(nextCompleter, backCompleter, tester);
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
      testCompleter(nextCompleter, backCompleter, tester);
    });



    testWidgets('choose recipe picture', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(MaterialApp(home: AddPicture(
        next: () {}, back: () {}, setPicture: (String picture) {},),));
      expect(find.text("Wie sieht dein Gericht aus?"), findsOneWidget);
      expect(find.text("Füge jetzt ein Foto hinzu"), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      await tester.tap(find.text("Foto auswählen"));
      await tester.pump();
      expect(find.text("Galerie"), findsOneWidget);
      expect(find.text("Kamera"), findsOneWidget);
      expect(find.byIcon(Icons.collections), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
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
