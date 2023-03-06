
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_ingredient.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_picture.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/confirm_screen.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_manual.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/name_recipe.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';


import 'package:http/http.dart' as http;

class CreateRecipeMainPage extends StatefulWidget {

  final bool? edit;
  final RARecipe? oldRecipe;

  const CreateRecipeMainPage({Key? key, this.edit, this.oldRecipe}) : super(key: key);

  @override
  State<CreateRecipeMainPage> createState() => _CreateRecipeMainPageState();
}

class _CreateRecipeMainPageState extends State<CreateRecipeMainPage> {
  RARecipe recipe = RARecipe(
    picture: "",
    title: "",
    description: "",
    ingredients: [],
    manual: [],
  );

  List<TextEditingController> controllers = [];

  int _currentIndex = 0;

  void setTitle(String title){
    setState(() {
      recipe.title = title;
    });
  }

  void setPicture(String picture) {
    setState(() {
      recipe.picture = picture;
    });
  }

  void next() {
    setState(() {
      _currentIndex++;
    });
  }

  void back() {
    setState(() {
      _currentIndex--;
    });
  }

  void postRecipe() async {

    var token = await FirebaseAuth.instance.currentUser!.getIdToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes'));
    request.body = json.encode(recipe);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  void editRecipe(){

  }


   late final List<Widget> _pages = [
    NameRecipe(next: next, recipe: recipe),
    AddIngredient(next: next, back: back, ingredients: recipe.ingredients, controllers: controllers,),
    CreateManual(next: next, back: back, manual: recipe.manual,),
    AddPicture(setPicture: setPicture, next: next, back: back,),
    ConfirmRecipe(upload: (){Navigator.pop(context); widget.edit ?? false ? editRecipe() : postRecipe(); }),
  ];

  @override
  void initState() {
    if(widget.edit ?? false){
      recipe = widget.oldRecipe!;
      for(RAIngredient ing in recipe.ingredients){
        TextEditingController controller = TextEditingController(text: ing.amount.toString());
        controller.addListener(() {ing.amount = int.parse(controller.text);});
        controllers.add(controller);
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        bottom: false,
        right: false,
        left: false,
        child: Container(
          child: _pages[_currentIndex],
        ),
      ),
    );
  }
}
