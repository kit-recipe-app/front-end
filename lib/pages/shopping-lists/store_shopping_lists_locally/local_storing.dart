

/*
class LocalStorage {
  final shoppingListPrefix = "shoppinglist_";

  Future<void> wipeData() async {
    final prefs = await SharedPreferences.getInstance();
    final shoppingListKeys = prefs.getKeys().where((key) =>
        key.isNotEmpty && key[0] != "_" && key.startsWith(shoppingListPrefix));
    for (String key in shoppingListKeys) {
      await prefs.remove(key);
    }
  }

///
  Future<bool> saveShoppingList(RAShoppingList shoppingList) async {
    if (await shoppingListExists(shoppingList.title)) {
      return false;
    }
    final prefs = await SharedPreferences.getInstance();
    String shoppingListKey = shoppingListPrefix + shoppingList.title;
    await prefs.setString(shoppingListKey, jsonEncode(shoppingList.toJson()));
    return true;
  }
///
  Future<void> updateShoppingList(RAShoppingList shoppingList) async {
    final prefs = await SharedPreferences.getInstance();
    String shoppingListKey = shoppingListPrefix + shoppingList.title;
    await prefs.setString(shoppingListKey, jsonEncode(shoppingList.toJson()));
  }
///
  Future<void> deleteSingleShoppingList(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final shoppingListKey = shoppingListPrefix + title;
    await prefs.remove(shoppingListKey);
  }
///
  Future<bool> shoppingListExists(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final shoppingListKeys = prefs.getKeys().where(
        (String key) => key.isNotEmpty && key.startsWith(shoppingListPrefix));
    return shoppingListKeys.contains(shoppingListPrefix + title);
  }
///
  Future<RAShoppingList?> getSingleShoppingList(
      String shoppingListTitle) async {
    if (!(await shoppingListExists(shoppingListTitle))) {
      return null;
    }
    final prefs = await SharedPreferences.getInstance();
    final shoppingListKey = shoppingListPrefix + shoppingListTitle;
    final shoppingListJson = prefs.getString(shoppingListKey);
    return RAShoppingList.fromJson(jsonDecode(shoppingListJson!));
  }
///
  Future<void> changeShoppingListTitle(String oldTitle, String newTitle) async {
    final prefs = await SharedPreferences.getInstance();
    RAShoppingList? shoppingList = await getSingleShoppingList(oldTitle);
    shoppingList!.title = newTitle;
    deleteSingleShoppingList(oldTitle);
    String newShoppingListKey = shoppingListPrefix + newTitle;
    await prefs.setString(
        newShoppingListKey, jsonEncode(shoppingList.toJson()));
  }

  Future<List<RAShoppingList>> getShoppingLists() async {
    final prefs = await SharedPreferences.getInstance();

    final shoppingListKeys = prefs.getKeys().where((key) =>
        key.isNotEmpty && key[0] != "_" && key.startsWith(shoppingListPrefix));
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
*/