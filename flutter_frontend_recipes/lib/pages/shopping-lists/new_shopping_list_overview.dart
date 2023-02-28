import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/new_shopping_list_item_overview.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/store_shopping_lists_locally/local_storing.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
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

  @override
  initState() {
    super.initState();
    currentShoppingListState = widget.shoppingList;
  }

  Future<void> changeShoppingListTitle(String newTitle) async {
    await LocalStorage()
        .changeShoppingListTitle(widget.shoppingList.title, newTitle);
    setState(() {
      currentShoppingListState.title = newTitle;
    });
  }

  Future<void> deleteSingleShoppingList(BuildContext context) async {
    LocalStorage().deleteSingleShoppingList(widget.shoppingList.title);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  Future<void> updateShoppingListItem(RAIngredient ingredient) async {
    setState(() {
      currentShoppingListState.deleteItem(ingredient);
      currentShoppingListState.addItem(ingredient);
    });
    await LocalStorage().updateShoppingList(currentShoppingListState);
  }

  Future<void> addShoppingListItem(RAIngredient ingredient) async {
    setState(() {
      currentShoppingListState.addItem(ingredient);
    });
    await LocalStorage().updateShoppingList(currentShoppingListState);
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
            hintText: "Name",
            controller: nameController,
          ),
          RAInputField(
            hintText: "Einheit",
            controller: unitController,
          ),
          RAInputField(
            hintText: "Menge",
            controller: amountController,
            onlyNumbers: true,
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
      title: RAInputField(
        hintText: "Titel ändern",
        controller: titleController,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RAButton(
            onTap: () {
              deleteSingleShoppingList(context);
            },
            description: "löschen",
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            iconColor: Colors.white,
            shadow: false,
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RecipeAppColorStyles.backGroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: Colors.black,
              ),
            ),
            title: Text(
              widget.shoppingList.title,
              style: const TextStyle(
                color: Colors.black,
              ),
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
                icon: const Icon(
                  Icons.edit,
                  size: 24,
                  color: Colors.black,
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
                      itemCount: widget.shoppingList.getItemAmount(),
                      itemBuilder: ((context, index) {
                        return RAShoppingListItemOverview(
                          updateShoppingListIngredient: updateShoppingListItem,
                          item: widget.shoppingList.items![index],
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
