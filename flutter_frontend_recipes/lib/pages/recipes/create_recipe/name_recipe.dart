import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_title.dart';

import 'create_recipe_progress.dart';

class NameRecipe extends StatefulWidget {

  final Function(String) setTitle;
  final Function() next;

  const NameRecipe({Key? key, required this.setTitle, required this.next}) : super(key: key);

  @override
  State<NameRecipe> createState() => _NameRecipeState();
}

class _NameRecipeState extends State<NameRecipe> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,20,0,0),
          child: Stack(
              children: [IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.black,
                  shadows: [Shadow(color: Colors.black, blurRadius: 1.0)],
                ),
              ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0,20,0,0),
                  child: Progress(total: 4, current: 1),
                ),]
          ),
        ),
        const RecipeTitle(name: "Gib deinem Gericht einen Namen"),
        Padding(
          padding: const EdgeInsets.all(32),
          child: TextField(
            textAlign: TextAlign.center,
            controller: nameController,
            decoration: const InputDecoration(
              //contentPadding: EdgeInsets.all(0),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              label: Center(
                child: Text("Rezeptname"),
              ),
              //hintText: "Rezeptname",
              floatingLabelBehavior: FloatingLabelBehavior.never,
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
                setState(() {
                  widget.setTitle(nameController.text);
                  widget.next();
                });
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddIngredient(name: nameController.text)),
                );*/
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
