import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/example_shopping_list.dart';

import '../pages/shopping-list-content-page.dart';


class OverviewCard extends StatelessWidget {
  ShoppingList shoppingList;
  OverviewCard({Key? key, required this.shoppingList}) : super(key: key);

  String subTitleTiles = 'Erstellt am ';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 4, 5, 4),
      child: Card(
        elevation: 3,
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShoppingListContentPage(
                      shoppingList:
                      shoppingList)),
            );
          },
          trailing: Icon(
            RecipeAppIcons.chain,
            color: RecipeAppColorStyles.unSelectedIconColor,
            size: 20,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shoppingList.title,
                  style: FontStyles.titleText,
                ),
                Text(
                  '$subTitleTiles ${shoppingList.date}',
                  style: FontStyles.subtitleForTiles,
                ),
              ],
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                RecipeAppIcons.profilePageIcon,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



