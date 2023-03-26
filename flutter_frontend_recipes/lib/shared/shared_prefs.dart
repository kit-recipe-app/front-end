import 'dart:convert';

import 'package:flutter_frontend_recipes/types/shopping_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A Singleton-Class used to manage local storage od data.
class SharedPrefs {
  final String shoppingListPrefix = "shoppinglist_"; // a constant string used as a prefix for shopping list keys in shared preferences.
  static late SharedPreferences _sharedPrefs; // an object of type SharedPreferences that stores the shared preferences data.

  /// a factory constructor used to create a new instance of the class.
  factory SharedPrefs() => SharedPrefs._internal();

  /// a private constructor used to create an instance of the class.
  SharedPrefs._internal();

  /// a method that initializes the _sharedPrefs object by calling SharedPreferences.getInstance().
  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  /// a method that returns the value of the stored theme preference.
  bool? getTheme() {
    return _sharedPrefs.getBool("selectedTheme");
  }

  /// a method that returns the value of a food preference specified by pref.
  bool getFoodPref(String pref) {
    return _sharedPrefs.getBool(pref) ?? false;
  }

  /// a method that returns the chosen food preference.
  String getChosenPref() {
    List<String> prefs = ["Omnivor", "Vegan", "Vegetarisch", "Pescetarisch"];
    for (String pref in prefs) {
      if (_sharedPrefs.getBool(pref) ?? false == true) {
        return pref;
      }
    }
    return "Omnivor";
  }

  /// a method that returns the value of an allergy preference specified by allergy.
  bool getAllergy(String allergy) {
    return _sharedPrefs.getBool(allergy) ?? false;
  }

  /// a method that sets the selected theme preference to value.
  void setTheme(bool value) {
    _sharedPrefs.setBool(
        "selectedTheme", value); // Using selectedThemeIndex from constant
  }

  /// a method that sets a food preference specified by pref to value.
  void setFoodPref(String pref, bool value) {
    _sharedPrefs.setBool(pref, value);
  }

  /// a method that sets an allergy preference specified by allergy to value.
  void setAllergy(String allergy, bool value) {
    _sharedPrefs.setBool(allergy, value);
  }

  ///  a method that sets multiple food preferences to value.
  void setMultiplePref(List<String> prefs, bool value) {
    for (String pref in prefs) {
      _sharedPrefs.setBool(pref, value);
    }
  }

  /// a method that clears all the shared preferences data.
  void clear() {
    _sharedPrefs.clear();
  }

  /// Shopping-List: Shared-Prefs-Loading-Methods

  /// a method that checks if a shopping list with the given title exists.
  bool shoppingListExists(String title) {
    final shoppingListKeys = _sharedPrefs.getKeys().where(
        (String key) => key.isNotEmpty && key.startsWith(shoppingListPrefix));
    return shoppingListKeys.contains(shoppingListPrefix + title);
  }

  /// a method that deletes a shopping list with the given title.
  void deleteSingleShoppingList(String title) {
    final shoppingListKey = shoppingListPrefix + title;
    _sharedPrefs.remove(shoppingListKey);
  }

  /// a method that saves a shopping list object.
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

  /// a method that updates a shopping list object.
  void updateShoppingList(RAShoppingList shoppingList) {
    String shoppingListKey = shoppingListPrefix + shoppingList.title;
    _sharedPrefs.setString(
      shoppingListKey,
      jsonEncode(
        shoppingList.toJson(),
      ),
    );
  }

  /// a method that retrieves a single shopping list object.
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

  /// a method that changes the title of a shopping list object.
  void changeShoppingListTitle(String oldTitle, String newTitle) {
    RAShoppingList? shoppingList = getSingleShoppingList(oldTitle);
    shoppingList!.title = newTitle;
    deleteSingleShoppingList(oldTitle);
    String newShoppingListKey = shoppingListPrefix + newTitle;
    _sharedPrefs.setString(
        newShoppingListKey, jsonEncode(shoppingList.toJson()));
  }

  /// a method that retrieves all the saved shopping list objects.
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

  /// a method that sets the value of a favorite item specified by id to value.
  void setFavorite(String id, bool value){
    _sharedPrefs.setBool(id, value);
  }

  /// a method that retrieves the value of a favorite item specified by id.
  bool? getFavorite(String id){
    return _sharedPrefs.getBool(id);
  }

}




