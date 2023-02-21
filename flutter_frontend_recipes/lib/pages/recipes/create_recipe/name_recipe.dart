import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_title.dart';

import '../../../types/recipe.dart';
import 'create_recipe_progress.dart';

class NameRecipe extends StatefulWidget {
  final Function() next;
  RARecipe recipe;

  NameRecipe({Key? key, required this.next, required this.recipe})
      : super(key: key);

  @override
  State<NameRecipe> createState() => _NameRecipeState();
}

class _NameRecipeState extends State<NameRecipe> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.recipe.title;
    descController.text = widget.recipe.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        Stack(children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
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
            child: Progress(total: 4, current: 1),
          ),
        ]),
        const RecipeTitle(
            name: "Gib deinem Gericht einen Namen und eine Beschreibung"),
        Padding(
          padding: const EdgeInsets.all(32),
          child: TextField(
            maxLength: 50,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
            controller: nameController,
            decoration: const InputDecoration(
              counterText: '',
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff66aa44), width: 1),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              label: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Rezeptname",
                    style: TextStyle(fontSize: 17, height: 3),
                  )),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: SizedBox(
            height: 250,
            child: TextField(
              textInputAction: TextInputAction.done,
              maxLength: 250,
              style: TextStyle(fontSize: 20),
              maxLines: 10,
              controller: descController,
              decoration: InputDecoration(
                  counterText: '',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xff66aa44), width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xff66aa44), width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Beschreibung",
                  labelStyle:
                      TextStyle(fontSize: 21, color: const Color(0xff66aa44)),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
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
                  //widget.setTitle(nameController.text);
                  widget.recipe.title = nameController.text;
                  widget.recipe.description = descController.text;
                  widget.next();
                });
              },
              child: const Text("Nächster Schritt"),
              style: ElevatedButton.styleFrom(
                  animationDuration: const Duration(seconds: 1),
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
