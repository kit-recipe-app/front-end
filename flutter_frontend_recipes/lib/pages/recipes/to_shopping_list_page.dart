import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

import '../../constants/color_styles.dart';
import '../../constants/font_styles.dart';
import '../../shared/shared_prefs.dart';
import '../../types/ingredient.dart';
import '../../types/shopping_list.dart';

/// Page that is displayed when user decides to add recipe to a shopping list.
class ToShoppingList extends StatefulWidget {
  final RARecipe recipe;

  const ToShoppingList({Key? key, required this.recipe}) : super(key: key);

  @override
  State<ToShoppingList> createState() => _ToShoppingListState();
}

class _ToShoppingListState extends State<ToShoppingList> {
  int counter = 1;

  Timer? timer;

  List<RAShoppingList> listsStored = [];

  _toShoppingList() async {
    final shoppingList = RAShoppingList(
        title: widget.recipe.title, creationDate: DateTime.now());
    for (RAIngredient ing in widget.recipe.ingredients) {
      if (counter != 1) {
        RAIngredient newIng = RAIngredient(
            name: ing.name,
            unit: ing.unit,
            amount: counter * ing.amount,
            calories: ing.calories);
        shoppingList.addItem(newIng);
      } else {
        shoppingList.addItem(ing);
      }
    }
    SharedPrefs().saveShoppingList(shoppingList);
  }

  _updateShoppingList(RAShoppingList shoppingList) async {
    for (RAIngredient ing in widget.recipe.ingredients) {
      shoppingList.addItem(ing);
    }
    SharedPrefs().updateShoppingList(shoppingList);
  }

  _loadShoppingLists() async {
    List<RAShoppingList> loadedLists = SharedPrefs().getShoppingLists();
    listsStored = loadedLists;
  }

  @override
  void initState() {
    _loadShoppingLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Theme.of(context).canvasColor,
          child: SafeArea(
            left: false,
            bottom: false,
            right: false,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Material(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 110,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _toShoppingList();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    //Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Neue Liste erstellen",
                                          style: TextStyle(fontSize: 23),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 1.5,
                                  thickness: 1.5,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Bestehende Einkaufslisten"),
                                            content: SizedBox(
                                              height: 300,
                                              width: 400,
                                              child: Scrollbar(
                                                thumbVisibility: true,
                                                child: ListView(
                                                  children: [
                                                    for (RAShoppingList list
                                                        in listsStored)
                                                      Card(
                                                        child: ListTile(
                                                          leading: const Icon(
                                                              Icons.add),
                                                          title:
                                                              Text(list.title),
                                                          onTap: () {
                                                            _updateShoppingList(
                                                                list);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            //Navigator.pop(context);
                                                          },
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text("Zu bestender Liste hinzufügen",
                                            style: TextStyle(fontSize: 23))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor:
                    RecipeAppColorStyles.navigationBarSelectedIconColor,
                title: Text(
                  "Zu Einkaufslisten",
                  style: FontStyles.appBarText,
                ),
              ),
              body: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Portion",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        button(false),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          counter.toString(),
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        button(true),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Zutaten",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (RAIngredient ing in widget.recipe.ingredients)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          '${counter * ing.amount} ${ing.unit} ${ing.name}'),
                    ),
                ],
              ),
            ),
          )),
    );
  }

  Widget button(bool positive) {
    return GestureDetector(
      key: positive ? const Key("Plus Button") : const Key("Minus Button"),
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if (positive ? counter < 100 : counter > 1) {
            setState(() {
              positive ? counter++ : counter--;
            });
          }
        });
      },
      onLongPressUp: () {
        timer?.cancel();
      },
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          if (positive ? counter < 100 : counter > 1) {
            setState(() {
              positive ? counter++ : counter--;
            });
          }
        },
        child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(positive ? Icons.add : Icons.remove)),
      ),
    );
  }
}
