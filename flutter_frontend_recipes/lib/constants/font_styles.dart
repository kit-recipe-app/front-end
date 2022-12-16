import 'package:flutter/material.dart';


// TODO: Die Inhalte sind erstmal nur Platzhalter, bis das endültige Design Feststeht
// TODO: Sobald das Design endgültig ist, müssen alle Werte geändert werden


// Hier werden die TextStyles für die verschiedenen Texte eingefügt, die dann verwendet werden
class FontStyles {


  // das ist für die Texte in Rezepten und Listen
  TextStyle normalText = const TextStyle(
    fontSize: 15,
    color: Colors.black,
  );

  // das ist für texte in den AppBars
  TextStyle appBarText = const TextStyle(
    fontSize: 25,
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

  // das ist ein Text, der für untere Titel der Listen gedacht ist
  TextStyle subtitleForTiles = const TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );




  TextStyle bigText = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 25,
    color: Colors.black,
  );

}

