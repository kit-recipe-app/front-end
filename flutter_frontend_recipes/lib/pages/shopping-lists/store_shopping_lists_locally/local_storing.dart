import 'dart:convert';

import 'package:flutter_frontend_recipes/types/shopping_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  final shoppingListPrefix = "shoppinglist_";

  Future<void> wipeData() async {
    final prefs = await SharedPreferences.getInstance();
    final shoppingListKeys = prefs
        .getKeys()
        .where((key) => key.isNotEmpty && key[0] != "_" && key.startsWith(shoppingListPrefix));
    for (String key in shoppingListKeys){
      await prefs.remove(key);
    }
  }

  Future<void> saveShoppingList(RAShoppingList shoppingList) async {
    final prefs = await SharedPreferences.getInstance();

    /*
    final List<String> itemsJson = shoppingList.items
            ?.map((item) => json.encode(item.toJson()))
            .toList() ??
        [];
    */

    //print(shoppingList.toJson().toString());
    await prefs.setString(
        shoppingListPrefix + shoppingList.title, jsonEncode(shoppingList.toJson()));
  }

  Future<void> deleteShoppingList(RAShoppingList shoppingList) async {
    
  }

  Future<List<RAShoppingList>> getShoppingLists() async {
    final prefs = await SharedPreferences.getInstance();

    final shoppingListKeys = prefs
        .getKeys()
        .where((key) => key.isNotEmpty && key[0] != "_" && key.startsWith(shoppingListPrefix));
    final List<RAShoppingList> shoppingLists = [];

    for (final shoppingListKey in shoppingListKeys) {
      final shoppingListJson = prefs.getString(shoppingListKey);
      if (shoppingListJson != null) {
        final test = jsonDecode(shoppingListJson);
        RAShoppingList shoppingList = RAShoppingList.fromJson(test);
        shoppingLists.add(shoppingList);
      }
    }
    return shoppingLists;
  }
}
