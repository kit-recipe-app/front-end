import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/widget_tile.dart';

class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  bool all = true;
  bool vegan = false;
  bool vegetarian = false;
  bool pescetarian = false;
  String title = "Nahrungsmittelpräferenzen";
  String allText = "Omnivor";
  String veganText = "Vegan";
  String vegetarianText = "Vegetarisch";
  String pescetarianText = "Pescetarisch";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        leading: const BackButton(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text(title, style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          WidgetTile(text: allText, info: Checkbox(
                  value: all,
                  onChanged: (bool? value) {
                    setState(() {
                     all = value!;
                     if (value){
                       vegan = vegetarian = pescetarian = false;
                     }
                    });
                  },
                )),
          const TileDivider(),
          WidgetTile(text: vegetarianText, info: Checkbox(
            value: vegetarian,
            onChanged: (bool? value) {
              setState(() {
                setState(() {
                  vegetarian = value!;
                  if (value){
                    vegan = all = pescetarian = false;
                  }
                });
              });
            },
          )),
          const TileDivider(),
          WidgetTile(text: veganText, info: Checkbox(
            value: vegan,
            onChanged: (bool? value) {
              setState(() {
                setState(() {
                  vegan = value!;
                  if (value){
                    all = vegetarian = pescetarian = false;
                  }
                });
              });
            },
          )),
          const TileDivider(),
          WidgetTile(text: pescetarianText, info: Checkbox(
            value: pescetarian,
            onChanged: (bool? value) {
              setState(() {
                setState(() {
                  pescetarian = value!;
                  if (value){
                    vegan = vegetarian = all = false;
                  }
                });
              });
            },
          )),
        ],
      )
    );
  }
}
