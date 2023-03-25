import 'package:flutter_frontend_recipes/types/ingredient.dart';

/// RAShoppingList represents a shopping list containing a title,
/// creation date, list of RAIngredient items, and whether it is a favorite or not.
class RAShoppingList {
  String title; // A string representing the title of the shopping list.
  DateTime creationDate; // A DateTime object representing the creation date of the shopping list.
  List<RAIngredient>? items; // An optional list of RAIngredient items representing the ingredients in the shopping list.
  bool favourite; // A boolean indicating whether the shopping list is a favorite or not.

  /// Constructor
  RAShoppingList(
      {required this.title,
      required this.creationDate,
      this.items,
      this.favourite = false});

  /// Returns the number of items in the shopping list. If the items list is null, returns 0.
  int getItemAmount() {
    return (items == null) ? 0 : items!.length;
  }

  /// Adds an RAIngredient object to the shopping list. If the items list is null, creates a new list with the item.
  /// If an item with the same name and unit already exists in the list, adds the amount of the new item to the existing item.
  /// If an item with the same name but different unit already exists in the list, adds the new item to the list as a new entry.
  void addItem(RAIngredient item) {
    if (items == null) {
      items = [item];
      return;
    }
    RAIngredient itemInList;
    if (items!.map((e) => e.name).contains(item.name)) {
      itemInList =
          items!.where((element) => element.name == item.name).toList()[0];
      if (itemInList.unit == item.unit) {
        items![items!.indexOf(itemInList)].amount += item.amount;
        return;
      }
    }
    items!.add(item);
  }

  /// Toggles the done boolean property of an RAIngredient object in the shopping list.
  void changeItemIsDone(RAIngredient item) {
    items![items!.indexOf(item)].done = !items![items!.indexOf(item)].done;
  }

  /// Removes an RAIngredient object from the shopping list.
  void deleteItem(RAIngredient item) {
    items!.remove(item);
  }

  /// Returns a JSON object representation of the shopping list.
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemsJson =
        items?.map((item) => item.toJsonLocal()).toList() ?? [];

    return {
      "title": title,
      "creationDate": creationDate.toIso8601String(),
      "items": itemsJson,
      "favourite": favourite,
    };
  }

  /// Factory constructor, to create a shopping list from a json object.
  factory RAShoppingList.fromJson(Map<String, dynamic> json) {
    List<dynamic>? itemsJson = json['items'];
    List<RAIngredient>? items = itemsJson
        ?.map((itemJson) => RAIngredient.fromJsonLocal(itemJson))
        .toList();

    return RAShoppingList(
      title: json['title'],
      creationDate: DateTime.parse(json['creationDate']),
      items: items,
      favourite: json['favourite'],
    );
  }
}
