import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/example_shopping_list.dart';
import '../page-components/create-content-lists.dart';

class ShoppingListContentPage extends StatefulWidget {
  ShoppingList shoppingList;
  ShoppingListContentPage({Key? key, required this.shoppingList})
      : super(key: key);

  @override
  State<ShoppingListContentPage> createState() =>
      _ShoppingListContentPageState();
}

class _ShoppingListContentPageState extends State<ShoppingListContentPage> {
  RecipeAppIcons iconDesigns = RecipeAppIcons();

  String addToContent = 'Hinzufügen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RecipeAppColorStyles.appBarBGColor,
        title: Text(
          widget.shoppingList.title,
          style: FontStyles.appBarText,
        ),
      ),
      body: Scrollbar(
        child: ListView(
            children: CreateContentLists().
            listsForShoppingListContent(widget.shoppingList.allRecipes),

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: RecipeAppColorStyles.addButtonColor,
          ),
          onPressed: () {},
          child: Text(
            addToContent,
            style: FontStyles.normalText,
          ),
        ),
      ),
    );
  }
}
