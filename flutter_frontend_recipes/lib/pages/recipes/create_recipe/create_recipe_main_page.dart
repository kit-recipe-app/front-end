
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_ingredient.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_picture.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/confirm_screen.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_manual.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/name_recipe.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

class CreateRecipeMainPage extends StatefulWidget {

  const CreateRecipeMainPage({Key? key}) : super(key: key);

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

  int _currentIndex = 0;

  void setTitle(String title){
    setState(() {
      recipe.title = title;
    });
  }

  void setDescription(String description){
    setState(() {
      recipe.description = description;
    });
  }

  void setIngredients(List<RAIngredient> ingredients){
    setState(() {
      recipe.ingredients = ingredients;
    });
  }

  void setManual(List<String> manual){
    setState(() {
      recipe.manual = manual;
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


   late final List<Widget> _pages = [
    NameRecipe(setTitle: setTitle, next: next,),
    AddIngredient(setIngredients: setIngredients, next: next, back: back,),
    CreateManual(setManual: setManual, next: next, back: back,),
    AddPicture(setPicture: setPicture, next: next, back: back,),
    ConfirmRecipe(upload: (){Navigator.pop(context);}),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _pages[_currentIndex],
    );
  }
}
