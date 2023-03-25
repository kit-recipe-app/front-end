import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list_item_overview.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class RAShoppingListOverview extends StatefulWidget {
  RAShoppingList shoppingList;
  RAShoppingListOverview({required this.shoppingList, super.key});

  @override
  State<RAShoppingListOverview> createState() => _RAShoppingListOverviewState();
}

class _RAShoppingListOverviewState extends State<RAShoppingListOverview> {
  bool orderedByCategory = false;
  late RAShoppingList currentShoppingListState;
  List<String> units = ["g", "kg", "St", "ml", "l"];

  @override
  initState() {
    super.initState();
    currentShoppingListState = widget.shoppingList;
  }

  void changeShoppingListTitle(String newTitle) {
    SharedPrefs().changeShoppingListTitle(widget.shoppingList.title, newTitle);
    setState(() {
      currentShoppingListState.title = newTitle;
    });
  }

  void deleteSingleShoppingList(BuildContext context) {
    SharedPrefs().deleteSingleShoppingList(widget.shoppingList.title);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void changeShoppingListItemDone(RAIngredient ingredient) {
    setState(() {
      currentShoppingListState.changeItemIsDone(ingredient);
    });
    SharedPrefs().updateShoppingList(currentShoppingListState);
  }

  void changeShoppingListItem(
      RAIngredient oldIngredient, RAIngredient newIngredient) {
    setState(() {
      currentShoppingListState.deleteItem(oldIngredient);
      currentShoppingListState.addItem(newIngredient);
    });
    SharedPrefs().updateShoppingList(currentShoppingListState);
  }

  void deleteShoppingListItem(RAIngredient ingredient) {
    setState(() {
      currentShoppingListState.deleteItem(ingredient);
    });
    SharedPrefs().updateShoppingList(currentShoppingListState);
  }

  void addShoppingListItem(RAIngredient ingredient) {
    setState(() {
      currentShoppingListState.addItem(ingredient);
    });
    SharedPrefs().updateShoppingList(currentShoppingListState);
  }

  Widget getItemAddDialogue(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController unitController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RAInputField(
            key: const Key("NameInput"),
            hintText: "Name",
            controller: nameController,
            charLimit: 200,
          ),
          RAInputField(
            key: const Key("MengeInput"),
            hintText: "Menge",
            controller: amountController,
            onlyNumbers: true,
            charLimit: 6,
          ),
          RAInputField(
            key: const Key("EinheitInput"),
            hintText: "Einheit",
            controller: unitController,
            charLimit: 10,
            quickSelect: units,
          ),
        ],
      ),
      actions: [
        RAButton(
          onTap: () {
            Navigator.pop(context);
          },
          description: "abbrechen",
          backgroundColor: Colors.black54,
        ),
        RAButton(
          onTap: () {
            if (nameController.text.isNotEmpty &&
                unitController.text.isNotEmpty &&
                amountController.text.isNotEmpty) {
              addShoppingListItem(
                RAIngredient(
                    name: nameController.text,
                    unit: unitController.text,
                    amount: int.parse(amountController.text),
                    calories: 0),
              );
            }
            Navigator.pop(context);
          },
          description: "ok",
          backgroundColor: Colors.green,
        ),
      ],
    );
  }

  Widget getEditingDialogue(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return AlertDialog(
      key: const Key("EditingDialouge"),
      title: RAInputField(
        hintText: "Titel ändern",
        controller: titleController,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[],
      ),
      actions: <Widget>[
        RAButton(
          onTap: () {
            Navigator.pop(context);
          },
          description: "abbrechen",
          backgroundColor: Colors.black54,
        ),
        RAButton(
          onTap: () {
            if (titleController.text.isNotEmpty) {
              changeShoppingListTitle(titleController.text);
            }
            Navigator.pop(context);
          },
          description: "ok",
          backgroundColor: Colors.green,
        ),
      ],
    );
  }

  Widget getConfirmDeleteDialogue(BuildContext context) {
    return AlertDialog(
      content: Text(
          "Sind Sie sicher, dass Sie die Einkaufsliste ${currentShoppingListState.title} löschen?"),
      actions: [
        RAButton(
          onTap: () {
            Navigator.pop(context);
          },
          description: "abbrechen",
          backgroundColor: Colors.black54,
        ),
        RAButton(
          onTap: () {
            deleteSingleShoppingList(context);
          },
          description: "löschen",
          backgroundColor: Colors.red,
        ),
      ],
    );
  }

  Widget getItemEditDialogue(BuildContext context, RAIngredient ingredient) {
    TextEditingController nameController = TextEditingController();
    TextEditingController unitController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RAInputField(
            hintText: ingredient.name,
            controller: nameController,
          ),
          RAInputField(
            hintText: ingredient.amount.toString(),
            controller: amountController,
            onlyNumbers: true,
            charLimit: 6,
          ),
          RAInputField(
            hintText: ingredient.unit,
            controller: unitController,
            charLimit: 10,
            quickSelect: units,
          ),
        ],
      ),
      actions: [
        RAButton(
          onTap: () {
            Navigator.pop(context);
          },
          description: "abbrechen",
          backgroundColor: Colors.black54,
        ),
        RAButton(
          onTap: () {
            changeShoppingListItem(
              ingredient,
              RAIngredient(
                name: (nameController.text.isEmpty)
                    ? ingredient.name
                    : nameController.text,
                unit: (unitController.text.isEmpty)
                    ? ingredient.unit
                    : unitController.text,
                amount: (amountController.text.isEmpty)
                    ? ingredient.amount
                    : int.parse(amountController.text),
                calories: 0,
              ),
            );
            Navigator.pop(context);
          },
          description: "ok",
          backgroundColor: Colors.green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            title: Text(
              widget.shoppingList.title,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        getEditingDialogue(context),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        getConfirmDeleteDialogue(context),
                  );
                },
                icon: Icon(
                  Icons.delete,
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
          body: (widget.shoppingList.getItemAmount() == 0)
              ? const Center(
                  child: Text("Noch keine Dinge auf der Liste"),
                )
              : Stack(
                  children: [
                    ListView.builder(
                      itemCount: currentShoppingListState.getItemAmount(),
                      itemBuilder: ((context, index) {
                        final item = currentShoppingListState.items![index];
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [Icon(Icons.delete)],
                            ),
                          ),
                          key: Key(item.toString()),
                          onDismissed: (direction) {
                            setState(() {
                              deleteShoppingListItem(item);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("${item.name} gelöscht"),
                                duration: const Duration(milliseconds: 1500),
                                action: SnackBarAction(
                                    label: "Undo",
                                    onPressed: () => setState(
                                        () => addShoppingListItem(item))),
                              ));
                            });
                          },
                          child: RAShoppingListItemOverview(
                            updateShoppingListIngredientDone:
                                changeShoppingListItemDone,
                            item: item,
                            onLongPress: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  getItemEditDialogue(context, item),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: RAButton(
            description: "Sache hinzufügen",
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => getItemAddDialogue(context),
              );
            },
          ),
        ),
      ),
    );
  }
}
