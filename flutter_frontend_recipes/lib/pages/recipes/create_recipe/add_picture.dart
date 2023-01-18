import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';
import 'package:image_picker/image_picker.dart';

import 'create_recipe_progress.dart';
import 'create_recipe_title.dart';

class AddPicture extends StatefulWidget {


  final String name;
  final List<RAIngredient> ingredients;
  final List<String> steps;

  const AddPicture({Key? key, required this.name, required this.ingredients, required this.steps}) : super(key: key);

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  var _image;
  var imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

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
                  child: Progress(total: 4, current: 4),
                ),]
          ),
        ),
        const RecipeTitle(name: "Wie sieht dein Gericht aus?"),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                "Füge jetzt ein Foto hinzu",
                style: TextStyle(fontSize: 16),
              )),
        ),
        GestureDetector(
          onTap: () async {
            var source = ImageSource.gallery;
            XFile image = await imagePicker.pickImage(
                source: source,
                imageQuality: 50,
                preferredCameraDevice: CameraDevice.front);
            setState(() {
              _image = File(image.path);
            });
          },
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: _image != null
                ? Image.file(
                    _image,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.fill,
                  )
                : Icon(
                      Icons.add,
                      color: Colors.grey[800],
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
                  MaterialPageRoute(builder: (context) => RecipeOverview(recipe: RARecipe(picture: 'assets/example_pictures/hamburger.jpg', title: widget.name, description: '', ingredients: widget.ingredients, manual: widget.steps))),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xff66aa44),
                  textStyle:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              child: const Text("Nächster Schritt"),
            ),
          ),
        )
      ],
    ));
  }
}
