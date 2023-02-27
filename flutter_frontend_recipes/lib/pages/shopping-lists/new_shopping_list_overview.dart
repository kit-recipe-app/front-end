import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/new_shopping_list_item_overview.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class RAShoppingListOverview extends StatefulWidget {
  RAShoppingList shoppingList;
  RAShoppingListOverview({required this.shoppingList, super.key});

  @override
  State<RAShoppingListOverview> createState() => _RAShoppingListOverviewState();
}

class _RAShoppingListOverviewState extends State<RAShoppingListOverview> {
  bool orderedByCategory = false;

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
              print("delete has to implemented");
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
            print("nothing happend");
            Navigator.pop(context);
          },
          description: "abbrechen",
          backgroundColor: Colors.black54,
        ),
        RAButton(
          onTap: () {
            print(titleController.text);
            print("Change name has to be implemented");
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
                          item: widget.shoppingList.items![index],
                        );
                      }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
