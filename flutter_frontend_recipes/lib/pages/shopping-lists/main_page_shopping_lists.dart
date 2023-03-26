import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/create_shopping_list/add_shopping_list_screen.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list_preview.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

/// Main Page of the ShoppingList-Section of the App.
/// All stored shopping lists are shown and can be sorted by favorites
class NewMainPageShoppingLists extends StatefulWidget {
  const NewMainPageShoppingLists({super.key});

  @override
  State<NewMainPageShoppingLists> createState() =>
      _NewMainPageShoppingListsState();
}

class _NewMainPageShoppingListsState extends State<NewMainPageShoppingLists> {
  List<RAShoppingList> listsStored = []; // Lists, that are displayed and stored
  bool sortByFavorite = false; // Flag, showing if lists are sorted by favorite

  /// Used to toggle between sorting the shopping lists by favorite or by date (default).
  void toggleListsStored() {
    setState(() {
      if (sortByFavorite) {
        loadShoppingLists();
        sortByFavorite = !sortByFavorite;
        return;
      }
      sortShoppingLists();
      sortByFavorite = !sortByFavorite;
    });
  }

  /// Sorts the shopping lists first by favorite, then by creationDate
  void sortShoppingLists() {
    setState(() {
      listsStored.sort(((a, b) {
        if (a.favourite) {
          if (b.favourite) {
            return a.creationDate.compareTo(b.creationDate);
          }
          return -1;
        }
        if (!b.favourite) {
          return a.creationDate.compareTo(b.creationDate);
        }
        return 1;
      }));
    });
  }

  /// used to load the shopping lists from shared preferences and sort them by date.
  void loadShoppingLists() {
    List<RAShoppingList> loadedLists = SharedPrefs().getShoppingLists();
    loadedLists.sort(((a, b) => a.creationDate.compareTo(b.creationDate)));
    setState(() {
      listsStored = loadedLists;
    });
  }

  @override
  void initState() {
    loadShoppingLists();
    super.initState();
  }

  /// Returns what is shown in 'NewMainPageShoppingLists'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deine Einkaufslisten",
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
        actions: [
          IconButton(
            onPressed: () {
              toggleListsStored();
            },
            icon: Icon(
              sortByFavorite ? Icons.star : Icons.star_border,
              size: 24,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
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
                        key: Key("${e.title} Preview"),
                        shoppingList: e,
                        reLoadRecipes: () {
                          loadShoppingLists();
                          if (sortByFavorite) {
                            sortShoppingLists();
                          }
                        },
                      ))
                  .toList()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RAButton(
        key: const Key("createShoppingListButton"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddShoppingListScreen(
                      key: Key("AddShoppingListPage"),
                    )),
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
