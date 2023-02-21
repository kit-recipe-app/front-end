import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/new_shopping_list_item_overview.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class RAShoppingListOverview extends StatefulWidget {
  RAShoppingList shoppingList;
  RAShoppingListOverview({required this.shoppingList, super.key});

  @override
  State<RAShoppingListOverview> createState() => _RAShoppingListOverviewState();
}

class _RAShoppingListOverviewState extends State<RAShoppingListOverview> {
  bool orderedByCategory = false;

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
                onPressed: () {},
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
