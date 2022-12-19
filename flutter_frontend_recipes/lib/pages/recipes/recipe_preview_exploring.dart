import 'package:flutter/material.dart';

class RecipeAppRecipePreviewExploring extends StatelessWidget {
  const RecipeAppRecipePreviewExploring({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/example_pictures/hamburger.jpg',
              width: 200,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            "Linsenburger mit Bailikum",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
              "Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, to")
        ],
      ),
    );
  }
}
