import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/create_shopping_list/add_shopping_list_screen.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list_preview.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class NewMainPageShoppingLists extends StatefulWidget {
  const NewMainPageShoppingLists({super.key});

  @override
  State<NewMainPageShoppingLists> createState() =>
      _NewMainPageShoppingListsState();
}

class _NewMainPageShoppingListsState extends State<NewMainPageShoppingLists> {
  List<RAShoppingList> listsStored = [];

  void loadShoppingLists() {
    List<RAShoppingList> loadedLists = SharedPrefs().getShoppingLists();
    setState(() {
      listsStored = loadedLists;
    });
  }

  @override
  void initState() {
    loadShoppingLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deine Einkaufslisten",
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
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
      body: (listsStored.isEmpty)
          ? const Center(child: Text("Noch keine Einkaufslisten hier"))
          : ListView(
              children: listsStored
                  .map((e) => ShoppingListPreview(
                        shoppingList: e,
                        reLoadRecipes: loadShoppingLists,
                      ))
                  .toList()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RAButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddShoppingListScreen()),
          ).then((value) => loadShoppingLists());
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
