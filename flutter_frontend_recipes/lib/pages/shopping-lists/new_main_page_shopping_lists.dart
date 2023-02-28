import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/create_shopping_list/test.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/new_shopping_list_preview.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/store_shopping_lists_locally/local_storing.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class NewMainPageShoppingLists extends StatefulWidget {
  const NewMainPageShoppingLists({super.key});

  @override
  State<NewMainPageShoppingLists> createState() =>
      _NewMainPageShoppingListsState();
}

class _NewMainPageShoppingListsState extends State<NewMainPageShoppingLists> {
  List<RAShoppingList> listsStored = [];

  Future<void> loadShoppingLists() async {
    List<RAShoppingList> loadedLists = await LocalStorage().getShoppingLists();
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
      body: (listsStored.isEmpty)
          ? const Center(child: Text("Noch keine Einkaufslisten hier"))
          : ListView(
              children: listsStored
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
