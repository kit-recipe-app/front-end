import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_ingredient.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/add_picture.dart';
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

  setTitle(String title){
    setState(() {
      recipe.title = title;
    });
  }

  setDescription(String description){
    setState(() {
      recipe.description = description;
    });
  }

  setIngredients(List<RAIngredient> ingredients){
    setState(() {
      recipe.ingredients = ingredients;
    });
  }

  setManual(List<String> manual){
    setState(() {
      recipe.manual = manual;
    });
  }

  int _currentIndex = 0;
  final List<Widget> _pages = [
    const NameRecipe(),
    /*const AddIngredient(name: name),
    const CreateManual(name: name, ingredients: ingredients),
    AddPicture(name: name, ingredients: ingredients, steps: steps),*/
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
