import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/content_examples/ingredient_examples.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_manual.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_title.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/ingredient_builder.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/search_ingredients.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../../types/ingredient.dart';
import 'create_recipe_progress.dart';
import 'package:flutter/services.dart';

class AddIngredient extends StatefulWidget {
  final String name;

  const AddIngredient({Key? key, required this.name}) : super(key: key);

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {

  String? selectedValueSingleDialog;
  List<RAIngredient> lis = [];
  int factor = 1;

  //widget.name übergeben

  addItem(RAIngredient ingredient) {
    setState(() {
      lis.add(ingredient);
    });
  }

  removeItem(RAIngredient ingredient) {
    setState(() {
      lis.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListView(
      children: [
        const Progress(total: 4, current: 2),
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
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.all(0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
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

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchIngredients(
                        addItem: addItem,
                      )),
            );
          },
          child: const Text("Zutat hinzufügen"),
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: const Color(0xff66aa44),
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        for (RAIngredient ing in lis)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(ing.name),
                  ),
                  const Spacer(),
                  Text("${factor * ing.amount} "),
                  Text(ing.unit),
                  IconButton(
                      onPressed: () => removeItem(ing),
                      icon: const Icon(Icons.remove))
                ],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateManual(name: widget.name)),
                );
              },
              child: const Text("Nächster Schritt"),
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xff66aa44),
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        )
      ],
    ));
  }
}
