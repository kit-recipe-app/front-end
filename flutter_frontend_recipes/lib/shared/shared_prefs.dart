import 'dart:convert';

import 'package:flutter_frontend_recipes/types/shopping_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final String shoppingListPrefix = "shoppinglist_";
  static late SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  bool? getTheme() {
    return _sharedPrefs.getBool("selectedTheme");
  }

  bool? getFoodPref(String pref) {
    return _sharedPrefs.getBool(pref);
  }

  String getChosenPref() {
    List<String> prefs = ["Omnivor", "Vegan", "Vegetarisch", "Pescetarisch"];
    for (String pref in prefs) {
      if (_sharedPrefs.getBool(pref) ?? false == true) {
        return pref;
      }
    }
    return "Omnivor";
  }

  bool? getAllergy(String allergy) {
    return _sharedPrefs.getBool(allergy);
  }

  void setTheme(bool value) {
    _sharedPrefs.setBool(
        "selectedTheme", value); // Using selectedThemeIndex from constant
  }

  void setFoodPref(String pref, bool value) {
    _sharedPrefs.setBool(pref, value);
  }

  void setAllergy(String allergy, bool value) {
    _sharedPrefs.setBool(allergy, value);
  }

  void setMultiplePref(List<String> prefs, bool value) {
    for (String pref in prefs) {
      _sharedPrefs.setBool(pref, value);
    }
  }

  void clear() {
    _sharedPrefs.clear();
  }

  // Shopping-List: Shared-Prefs-Loading-Methods

  bool shoppingListExists(String title) {
    //final prefs = await SharedPreferences.getInstance();
    final shoppingListKeys = _sharedPrefs.getKeys().where(
        (String key) => key.isNotEmpty && key.startsWith(shoppingListPrefix));
    return shoppingListKeys.contains(shoppingListPrefix + title);
  }

  void deleteSingleShoppingList(String title) {
    final shoppingListKey = shoppingListPrefix + title;
    _sharedPrefs.remove(shoppingListKey);
  }

  bool saveShoppingList(RAShoppingList shoppingList) {
    if (shoppingListExists(shoppingList.title)) {
      return false;
    }
    String shoppingListKey = shoppingListPrefix + shoppingList.title;
    _sharedPrefs.setString(
      shoppingListKey,
      jsonEncode(
        shoppingList.toJson(),
      ),
    );
    return true;
  }

  void updateShoppingList(RAShoppingList shoppingList) {
    String shoppingListKey = shoppingListPrefix + shoppingList.title;
    _sharedPrefs.setString(
      shoppingListKey,
      jsonEncode(
        shoppingList.toJson(),
      ),
    );
  }

  RAShoppingList? getSingleShoppingList(String shoppingListTitle) {
    if (!(shoppingListExists(shoppingListTitle))) {
      return null;
    }
    final shoppingListKey = shoppingListPrefix + shoppingListTitle;
    final shoppingListJson = _sharedPrefs.getString(shoppingListKey);
    return RAShoppingList.fromJson(
      jsonDecode(shoppingListJson!),
    );
  }

  void changeShoppingListTitle(String oldTitle, String newTitle) {
    RAShoppingList? shoppingList = getSingleShoppingList(oldTitle);
    shoppingList!.title = newTitle;
    deleteSingleShoppingList(oldTitle);
    String newShoppingListKey = shoppingListPrefix + newTitle;
    _sharedPrefs.setString(
        newShoppingListKey, jsonEncode(shoppingList.toJson()));
  }

  List<RAShoppingList> getShoppingLists() {
    final shoppingListKeys = _sharedPrefs.getKeys().where((key) =>
        key.isNotEmpty && key[0] != "_" && key.startsWith(shoppingListPrefix));
    final List<RAShoppingList> shoppingLists = [];
    for (final shoppingListKey in shoppingListKeys) {
      final shoppingListJson = _sharedPrefs.getString(shoppingListKey);
      if (shoppingListJson != null) {
        final test = jsonDecode(shoppingListJson);
        RAShoppingList shoppingList = RAShoppingList.fromJson(test);
        shoppingLists.add(shoppingList);
      }
    }
    return shoppingLists;
  }
}
