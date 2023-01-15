import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/content_examples/ingredient_examples.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_title.dart';
import '../../../types/ingredient.dart';
import 'add_ingredient.dart';
import 'create_recipe_progress.dart';

class CreateManual extends StatefulWidget {
  final String name;

  const CreateManual({Key? key, required this.name}) : super(key: key);

  @override
  State<CreateManual> createState() => _CreateManualState();
}

class _CreateManualState extends State<CreateManual> {
  TextEditingController nameController = TextEditingController();
  String? selectedValueSingleDialog;
  //widget.name übergeben



  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
          children: [
            const Progress(total: 4, current: 3),
            const RecipeTitle(
                name: "Verrate uns, wie man dein Rezept zubereitet"),
            Text(widget.name),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddIngredient(name: 'a',)),
                    );
                  },
                  child: const Text("Neuer Schritt"),
                  style: ElevatedButton.styleFrom(
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      textStyle:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddIngredient(name: "a")),
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
