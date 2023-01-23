import 'package:flutter/material.dart';

class RecipeTitle extends StatelessWidget {
  final String name;
  const RecipeTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          name,
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
