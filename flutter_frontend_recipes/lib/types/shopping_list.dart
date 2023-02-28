import 'package:flutter_frontend_recipes/types/ingredient.dart';

class RAShoppingList {
  String title;
  DateTime creationDate;
  List<RAIngredient>? items;
  bool favourite;

  RAShoppingList(
      {required this.title,
      required this.creationDate,
      this.items,
      this.favourite = false});

  int getItemAmount() {
    return (items == null) ? 0 : items!.length;
  }

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
        items![items!.indexOf(itemInList)].amount += itemInList.amount;
        return;
      }
    }
    items!.add(item);
  }

  void deleteItem(RAIngredient item) {
    items!.remove(item);
  }

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
