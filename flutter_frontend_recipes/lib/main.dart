import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/recipe_app.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Recipe App',
      home: RecipeApp(),
    );
  }
}
