import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/backend_connection/unit_loader.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list_item_overview.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

/// Page that is shown when user clicks on shopping list.
/// Title, buttons to change list and items stored in the list
class RAShoppingListOverview extends StatefulWidget {
  RAShoppingList shoppingList; // The shopping list to be displayed
  RAShoppingListOverview({required this.shoppingList, super.key});

  @override
  State<RAShoppingListOverview> createState() => _RAShoppingListOverviewState();
}

class _RAShoppingListOverviewState extends State<RAShoppingListOverview> {
  late RAShoppingList currentShoppingListState; // The shopping lists current state during widget runtime
  List<String> units = UnitLoader.units;

  @override
  initState() {
    super.initState();
    currentShoppingListState = widget.shoppingList;
  }

  /// A method that changes the title of the current shopping list
  /// to the new title passed as a parameter. It calls a method
  /// changeShoppingListTitle from the SharedPrefs class to persist
  /// the change and updates the state of the widget by calling setState().
  void changeShoppingListTitle(String newTitle) {
    SharedPrefs().changeShoppingListTitle(widget.shoppingList.title, newTitle);
    setState(() {
      currentShoppingListState.title = newTitle;
    });
  }

  /// A method that deletes the current shopping list from the local storage
  /// and navigates back to the previous screen. It calls a method
  /// deleteSingleShoppingList from the SharedPrefs class to delete the shopping
  /// list and navigates back to the previous screen.
  void deleteSingleShoppingList(BuildContext context) {
    SharedPrefs().deleteSingleShoppingList(widget.shoppingList.title);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  /// A method that toggles the done status of an ingredient in the current
  /// shopping list. It calls a method changeItemIsDone on the currentShoppingListState
  /// and updates the local storage by calling a method updateShoppingList from the
  /// SharedPrefs class. It also updates the state of the widget by calling setState().
  void changeShoppingListItemDone(RAIngredient ingredient) {
    setState(() {
      currentShoppingListState.changeItemIsDone(ingredient);
    });
    SharedPrefs().updateShoppingList(currentShoppingListState);
  }

  /// A method that replaces an old ingredient with a new one in the current shopping
  /// list. It calls methods deleteItem and addItem on the currentShoppingListState
  /// and updates the local storage by calling a method updateShoppingList from the
  /// SharedPrefs class. It also updates the state of the widget by calling setState().
  void changeShoppingListItem(
      RAIngredient oldIngredient, RAIngredient newIngredient) {
    setState(() {
      currentShoppingListState.deleteItem(oldIngredient);
      currentShoppingListState.addItem(newIngredient);
    });
    SharedPrefs().updateShoppingList(currentShoppingListState);
  }

  /// A method that removes an ingredient from the current shopping list. It calls a
  /// method deleteItem on the currentShoppingListState and updates the local storage
  /// by calling a method updateShoppingList from the SharedPrefs class. It also updates
  /// the state of the widget by calling setState().
  void deleteShoppingListItem(RAIngredient ingredient) {
    setState(() {
      currentShoppingListState.deleteItem(ingredient);
    });
    SharedPrefs().updateShoppingList(currentShoppingListState);
  }

  /// A method that adds a new ingredient to the current shopping list. It calls a
  /// method addItem on the currentShoppingListState and updates the local storage
  /// by calling a method updateShoppingList from the SharedPrefs class. It also
  /// updates the state of the widget by calling setState().
  void addShoppingListItem(RAIngredient ingredient) {
    setState(() {
      currentShoppingListState.addItem(ingredient);
    });
    SharedPrefs().updateShoppingList(currentShoppingListState);
  }

  /// Returns a Dialogue which can be used to add a new item to the shopping list
  Widget getItemAddDialogue(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController unitController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return AlertDialog(
      key: const Key("ItemAddDialogue"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RAInputField(
            key: const Key("NewItemName"),
            hintText: "Name",
            controller: nameController,
            charLimit: 200,
          ),
          RAInputField(
            key: const Key("NewItemAmount"),
            hintText: "Menge",
            controller: amountController,
            onlyNumbers: true,
            charLimit: 6,
          ),
          RAInputField(
            key: const Key("NewItemUnit"),
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
          key: const Key("AddItemConfirmButton"),
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

  /// Returns a Dialogue which can be used to edit the title of the shopping list
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

  /// Returns a Dialogue which makes the user consent deleting the shopping list
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

  /// Returns a Dialogue which can be used to edit an existing item in the shopping list
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

  /// Returns what is shown in 'RAShoppingListOverview'
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              key: const Key("BackButtonShoppingListOverview"),
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
                            key:
                                Key("${item.name} ${item.amount} ${item.unit}"),
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
            key: const Key("AddItemToShoppingListButton"),
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
