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
    Color activeColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: BackButton(
            color: Theme.of(context).colorScheme.onSecondary,
        ),
        title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
      ),
      body: Column(
        children: [
          WidgetTile(text: allText, info: Checkbox(
            activeColor: activeColor,
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
            activeColor: activeColor,
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
            activeColor: activeColor,
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
            activeColor: activeColor,
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
