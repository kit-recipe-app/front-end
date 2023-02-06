import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/pages/add-shopping-list-page.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/pages/shopping-list-overview-page.dart';

class MainPageShoppingLists extends StatefulWidget {
  const MainPageShoppingLists({Key? key}) : super(key: key);

  @override
  State<MainPageShoppingLists> createState() => _MainPageShoppingListsState();
}

class _MainPageShoppingListsState extends State<MainPageShoppingLists> {
  RecipeAppIcons iconDesigns = RecipeAppIcons();

  String title = 'Einkaufslisten';
  String addNewList = 'Liste erstellen';
  String cancel = 'Abbrechen';
  String currentText = 'Liste erstellen';
  int currentIndex = 0;

  List<Widget> shoppingListPages = [
    const ShoppingListOverview(),
    const AddShoppingList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff66aa44),
        title: Text(
          title,
          style: FontStyles.appBarText,
        ),
      ),
      body: shoppingListPages[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: RecipeAppColorStyles.addButtonColor,
          ),
          onPressed: () {
            if (currentIndex == 0) {
              setState(() {
                currentIndex = 1;
                currentText = cancel;
              });
            } else if (currentIndex == 1) {
              setState(() {
                currentIndex = 0;
                currentText = addNewList;
              });
            }
          },
          child: Text(
            currentText,
            style: FontStyles.normalText,
          ),
        ),
      ),
    );
  }
}
