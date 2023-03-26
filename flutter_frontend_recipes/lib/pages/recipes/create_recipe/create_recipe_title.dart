import 'package:flutter/material.dart';

///Title of the different pages in the recipe creation process
class RecipeTitle extends StatelessWidget {
  final String name;
  const RecipeTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 30, 35, 8),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xff66aa44),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
