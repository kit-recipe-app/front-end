import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/colors.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/example_shopping_list.dart';
import 'package:flutter_frontend_recipes/pages/recipes/example_ingredients.dart';

class ShoppingListContentPage extends StatefulWidget {
  ShoppingList shoppingList;
  ShoppingListContentPage({Key? key, required this.shoppingList}) : super(key: key);

  @override
  State<ShoppingListContentPage> createState() => _ShoppingListContentPageState();
}





class a {
  Ingredients ingredient;
  bool? value;
  String name = '';
  int amount = 0;
  String  unit = '';

  a({required this.ingredient, required this.value}) {
    name = ingredient.name;
    amount = ingredient.amount;
    unit = ingredient.unit;

  }


}





class _ShoppingListContentPageState extends State<ShoppingListContentPage> {

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  int indexOfIngredientsFromRecipe = 0;


  Widget createColumnForAllIngredients(List<Ingredients> allIngredients) {

    bool? isChecked = false;

    List<Widget> widgetList = [];
    for (var element in allIngredients) {
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Container(
              width: 100,
              child: Text(element.name),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Container(
              width: 50,
              child: Text('${element.amount}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Container(
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

                }
            );

    }
    )
        ],
      )
      );

      widgetList.add(Container(
        color: Colors.grey[400],
        height: 2,
        width: 300,
      ));
    }


    return Column(children: widgetList,);
  }




  bool? h = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDesigns.appBarBGColor,
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
                    subtitle: createColumnForAllIngredients(widget.
                    shoppingList.allRecipes[index].ingredients),
                  ),
          ),
              );
        }
        ),
      ),

    );
  }
}




class Deleteme extends StatefulWidget {
  const Deleteme({Key? key}) : super(key: key);

  @override
  State<Deleteme> createState() => _DeletemeState();
}

class _DeletemeState extends State<Deleteme> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




