import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/example_shopping_list.dart';
import 'package:flutter_frontend_recipes/pages/recipes/example_ingredients.dart';

class ShoppingListContentPage extends StatefulWidget {
  ShoppingList shoppingList;
  ShoppingListContentPage({Key? key, required this.shoppingList})
      : super(key: key);

  @override
  State<ShoppingListContentPage> createState() =>
      _ShoppingListContentPageState();
}

class _ShoppingListContentPageState extends State<ShoppingListContentPage> {
  FontStyles fontStyles = FontStyles();
  RecipeAppIcons iconDesigns = RecipeAppIcons();

  String addToContent = 'Hinzufügen';

  Widget createColumnForAllIngredients(List<Ingredients> allIngredients) {
    bool? isChecked = false;

    List<Widget> widgetList = [];
    for (var element in allIngredients) {
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              width: 100,
              child: Text(element.name),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              width: 50,
              child: Text('${element.amount}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              width: 50,
              child: Text(element.unit),
            ),
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Checkbox(
                value: isChecked,
                activeColor: Colors.green,
                onChanged: (newBool) {
                  setState(() {
                    isChecked = newBool;
                  });
                });
          })
        ],
      ));

      widgetList.add(Container(
        color: Colors.grey[400],
        height: 2,
        width: 300,
      ));
    }

    return Column(
      children: widgetList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RecipeAppColorStyles.appBarBGColor,
        title: Text(
          widget.shoppingList.title,
          style: fontStyles.appBarText,
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: widget.shoppingList.allRecipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.shoppingList.allRecipes[index].title,
                      ),
                    ),
                    subtitle: createColumnForAllIngredients(
                        widget.shoppingList.allRecipes[index].ingredients),
                  ),
                ),
              );
            }),
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
            style: fontStyles.normalText,
          ),
        ),
      ),
    );
  }
}
