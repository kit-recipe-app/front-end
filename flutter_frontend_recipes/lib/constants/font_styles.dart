import 'package:flutter/material.dart';


class FontStyles {


  // das ist für die Texte in Rezepten und Listen
  TextStyle normalText = const TextStyle(
    fontSize: 15,
    letterSpacing: 1,
    color: Colors.black,
  );

  // das ist für texte in den AppBars
  TextStyle appBarText = const TextStyle(
    fontSize: 15,
    letterSpacing: 1,
    color: Colors.white,
  );

  // das ist ein Text für einen Titel, der entweder Titel einer Liste oder eines Rezeptes ist
  TextStyle titleText = const TextStyle(
    fontSize: 20,
    letterSpacing: 1,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

}

