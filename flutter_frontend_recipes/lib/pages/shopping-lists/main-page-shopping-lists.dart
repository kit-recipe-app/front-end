import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/colors.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/add-shopping-list-page.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping-list-overview-page.dart';



class MainPageShoppingLists extends StatefulWidget {
  const MainPageShoppingLists({Key? key}) : super(key: key);

  @override
  State<MainPageShoppingLists> createState() => _MainPageShoppingListsState();
}


class _MainPageShoppingListsState extends State<MainPageShoppingLists> {

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  String title = 'Einkaufslisten';
  String addNewList = 'Liste erstellen';
  String cancel = 'Abbrechen';
  String currentText = 'Liste erstellen';
  int currentIndex = 0;

  List<Widget> shoppingListPages = [
    ShoppingListOverview(),
    AddShoppingList(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorDesigns.appBarBGColor,
        title: Text(
          title,
          style: fontStyles.appBarText,
        ),
      ),
      body: shoppingListPages[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      SizedBox( width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorDesigns.addButtonColor,
          ),
          onPressed: () {
            if (currentIndex == 0){
              setState(() {
                currentIndex = 1;
                currentText = cancel;
              });
            }
            else if (currentIndex == 1){
              setState(() {
                currentIndex = 0;
                currentText = addNewList;
              });
            }
          },
          child: Text(
            currentText,
            style: fontStyles.normalText,
          ),
        ),
      ),

    );
  }
}



