import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_title.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/ingredient_list_item.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/search_ingredients.dart';
import '../../../types/ingredient.dart';
import 'create_recipe_progress.dart';
import 'package:flutter/services.dart';

class AddIngredient extends StatefulWidget {

  //final Function(List<RAIngredient>) setIngredients;
  final Function() next;
  final Function() back;
  List<RAIngredient> ingredients;
  List<TextEditingController> controllers;
  List<RAIngredient> allIngredients;

  AddIngredient({Key? key, required this.next, required this.back, required this.ingredients, required this.controllers, required this.allIngredients}) : super(key: key);

  @override
  State<AddIngredient> createState() => AddIngredientState();
}

@visibleForTesting
class AddIngredientState extends State<AddIngredient> {

  List<TextEditingController> controllers = [];
  List<RAIngredient> lis = [];

  int factor = 1;
  List<String> units = ["g", "Stück", "ml", "kg", "Blatt"];

  addItem(RAIngredient ingredient) {
    setState(() {
      lis.add(ingredient);
      TextEditingController controller = TextEditingController(text: ingredient.amount.toString());
      controller.addListener(() {ingredient.amount = int.parse(controller.text);});
      controllers.add(controller);

    });
  }

  removeItem(RAIngredient ingredient, int index) {
    setState(() {
      lis.remove(ingredient);
      controllers.removeAt(index);
    });
  }

  @override
  void initState() {
    controllers = widget.controllers;
    lis = widget.ingredients;
    super.initState();
  }

 /* @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the
    // widget tree.
    for (TextEditingController controller in controllers){
      controller.dispose();
    }
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          widget.back();
        });
        return Future.value(false);
      },
      child: Material(
          child: Column(
        children: [
          Stack(children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.back();
                });
              },
              icon: Icon(
                Icons.arrow_back,
                size: 32,
                color: Theme.of(context).colorScheme.onSecondary,
                shadows: [Shadow(color: Colors.black, blurRadius: 1.0)],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Progress(total: 4, current: 2),
            ),
          ]),
          Expanded(
            child: ListView(
              children: [
                const RecipeTitle(
                    name: "Füge jetzt die Zutaten hinzu, die du brauchst"),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Zutaten:",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      const Text(
                        "für",
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: SizedBox(
                          height: 25,
                          width: 50,
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (text != "") {
                                  factor = int.parse(text);
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              //contentPadding: EdgeInsets.all(0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              label: Center(
                                child: Text("1"),
                              ),
                              //hintText: "Rezeptname",
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "Personen",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchIngredients(
                              ingredientList: widget.allIngredients,
                                  addItem: addItem,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: const Color(0xff66aa44),
                        textStyle:
                            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    child: const Text("Zutat hinzufügen"),
                  ),
                ),
                for (RAIngredient ing in lis)
                  IngredientListItem(units: units, controllers: controllers, ing: ing, removeItem: removeItem, lis: lis)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.next();
                  });
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color(0xff66aa44),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                child: const Text("Nächster Schritt"),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
