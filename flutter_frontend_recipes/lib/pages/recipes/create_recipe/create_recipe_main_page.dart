import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/backend_connection/ingredient_loader.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_ingredient.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_picture.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/confirm_screen.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_manual.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/name_recipe.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';


import 'package:http/http.dart' as http;


///Main page of recipe creation/editing process, displays the different steps of the process
class CreateRecipeMainPage extends StatefulWidget {

  ///Whether this page is used to create or edit a recipe.
  final bool? edit;

  ///If this page is used to edit recipe, this is the old recipe to be edited, else null.
  final RARecipe? oldRecipe;

  const CreateRecipeMainPage({Key? key, this.edit, this.oldRecipe}) : super(key: key);

  @override
  State<CreateRecipeMainPage> createState() => _CreateRecipeMainPageState();
}

class _CreateRecipeMainPageState extends State<CreateRecipeMainPage> {


  ///[RARecipe] that is initialized as empty and passed to the different pages
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


  ///Goes to the next step of the recipe creation/editing process.
  void next() {
    setState(() {
      _currentIndex++;
    });
  }

  ///Goes to the last step of the recipe creation/editing process.
  void back() {
    setState(() {
      _currentIndex--;
    });
  }

  ///Send recipe to backend using POST Request.
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
      var recipeId = await response.stream.bytesToString();
      if (!recipe.picture.startsWith("assets")) {
        var request = http.MultipartRequest('POST', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/images'));
        request.files.add(await http.MultipartFile.fromPath('image', recipe.picture));
        request.headers.addAll(headers);

        http.StreamedResponse response2 = await request.send();

        if (response2.statusCode == 200) {
          var pictureId = await response2.stream.bytesToString();
          var request = http.Request('POST', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/recipes/$recipeId/image/$pictureId'));

          request.headers.addAll(headers);

          http.StreamedResponse response3 = await request.send();

          if (response3.statusCode == 200) {
            print(await response3.stream.bytesToString());
          }
          else {
            print(response.reasonPhrase);
          }
        }
        else {
          print(response2.reasonPhrase);
        }
      }
    }
    else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }


  }

  ///Send edited recipe to backend using PUT Request
  void editRecipe() async{
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    print(recipe.id);
    var request = http.Request('PUT', Uri.parse('https://recipebackendnew-qgf6rz2woa-ey.a.run.app/api/v1/user/recipes/${recipe.id}'));
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


  ///Different pages to be displayed during the Recipe creation/editing process.
   late final List<Widget> _pages = [
    NameRecipe(next: next, recipe: recipe),
    AddIngredient(next: next, back: back, ingredients: recipe.ingredients, controllers: controllers, allIngredients: IngredientLoader.ingredients,),
    CreateManual(next: next, back: back, manual: recipe.manual,),
    AddPicture(setPicture: setPicture, next: next, back: back,),
    ConfirmRecipe(upload: (){Navigator.pop(context); widget.edit ?? false ? editRecipe() : postRecipe(); }),
  ];

  @override
  void initState() {
    if(widget.edit ?? false){
      ///If page is used to edit a recipe, the recipe held by this page is not initialized as empty, but as the old recipe.
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
