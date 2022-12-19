import 'package:flutter/material.dart';

class LastSeenRecipe {
  // Bild ist nur Platzhalter
  SizedBox card = const SizedBox(
    height: 110,
    width: 355,
    child: Image(
      fit: BoxFit.fitWidth,
      image: AssetImage('assets/example_pictures/hamburger.jpg'),
    ),
  );
}
