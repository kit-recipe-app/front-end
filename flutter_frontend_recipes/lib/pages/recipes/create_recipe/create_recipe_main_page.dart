
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_ingredient.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_picture.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/confirm_screen.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_manual.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/name_recipe.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

import '../../../constants/color_styles.dart';

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

  List<TextEditingController> controllers = [];

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

  /*void setIngredients(List<RAIngredient> ingredients){
    setState(() {
      recipe.ingredients = ingredients;
    });
  }*/

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
    NameRecipe(next: next, title: recipe.title, setTitle: setTitle),
    AddIngredient(next: next, back: back, ingredients: recipe.ingredients, controllers: controllers,),
    CreateManual(next: next, back: back, manual: recipe.manual,),
    AddPicture(setPicture: setPicture, next: next, back: back,),
     RecipeOverview(recipe: recipe)
    //ConfirmRecipe(upload: (){Navigator.pop(context);}),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RecipeAppColorStyles.backGroundColor,
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
