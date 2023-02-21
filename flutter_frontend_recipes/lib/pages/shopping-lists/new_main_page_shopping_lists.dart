import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/content_examples/recipe_examples.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/create_shopping_list/test.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/new_shopping_list_preview.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/store_shopping_lists_locally/local_storing.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class NewMainPageShoppingLists extends StatefulWidget {
  const NewMainPageShoppingLists({super.key});

  @override
  State<NewMainPageShoppingLists> createState() =>
      _NewMainPageShoppingListsState();
}

class _NewMainPageShoppingListsState extends State<NewMainPageShoppingLists> {
  // Items
  RAIngredient ingr1 = RAIngredient(
      name: "Banane",
      unit: "Stück",
      amount: 3,
      calories: 120,
      category: "Obst und Gemüse",
      recipe: RecipeExamples.testRecipe1);

  RAIngredient ingr2 = RAIngredient(
      name: "Milch",
      unit: "ml",
      amount: 300,
      calories: 93,
      category: "Milchprodukte");

  RAIngredient ingr3 = RAIngredient(
      name: "Quark",
      unit: "gr",
      amount: 150,
      calories: 413,
      category: "Milchprodukte");

  RAIngredient ingr4 = RAIngredient(
      name: "Gurke",
      unit: "Stück",
      amount: 1,
      calories: 65,
      category: "Obst und Gemüse");

  RAIngredient ingr5 = RAIngredient(
      name: "Hähnchenbrust",
      unit: "gr",
      amount: 400,
      calories: 1200,
      category: "Fisch und Fleisch");

  RAIngredient ingr6 = RAIngredient(
    name: "Salz",
    unit: "Prise",
    amount: 3,
    calories: 0,
    category: "Gewürze",
  );

  RAIngredient ingr7 = RAIngredient(
      name: "Pfeffer",
      unit: "Prise",
      amount: 2,
      calories: 0,
      category: "Gewürze");

  RAIngredient ingr8 = RAIngredient(
      name: "Mehl",
      unit: "gr",
      amount: 200,
      calories: 652,
      category: "Sonstiges");

  // Lists
  RAShoppingList test1 = RAShoppingList(
    title: "Familie Boyn",
    creationDate: DateTime.now(),
    favourite: true,
  );

  late RAShoppingList test2 = RAShoppingList(
    title: "Picknick",
    creationDate: DateTime.now(),
    items: [
      ingr1,
      ingr2,
      ingr3,
      ingr4,
      ingr5,
      ingr6,
      ingr7,
      ingr8,
    ],
  );

  RAShoppingList test3 = RAShoppingList(
    title: "Wocheneinkauf",
    creationDate: DateTime.now(),
  );

  List<RAShoppingList> lists_stored = [];

  Future<void> loadShoppingLists() async {
    List<RAShoppingList> loadedLists = await LocalStorage().getShoppingLists();
    setState(() {
      lists_stored = loadedLists;
    });
  }

  @override
  void initState() {
    loadShoppingLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadShoppingLists();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Deine Einkaufslisten",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: (lists_stored.isEmpty)
          ? const Center(child: Text("Noch keine Einkaufslisten hier"))
          : ListView(
              children: lists_stored
                  .map((e) => NewShoppingListPreview(shoppingList: e))
                  .toList()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RAButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddShoppingListScreen()),
          );
        },
        description: "Einkaufsliste erstellen",
        padding: const EdgeInsets.fromLTRB(48, 16, 48, 16),
        textColor: Colors.black,
        backgroundColor: const Color(0xffe1e1e1),
        shadow: false,
      ),
    );
  }
}
