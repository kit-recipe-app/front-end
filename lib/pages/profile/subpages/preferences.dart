import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/widget_tile.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';

class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  bool all = SharedPrefs().getFoodPref(allText);
  bool vegan = SharedPrefs().getFoodPref(veganText);
  bool vegetarian = SharedPrefs().getFoodPref(vegetarianText);
  bool pescetarian = SharedPrefs().getFoodPref(pescetarianText);

  String title = "Nahrungsmittelpräferenzen";
  static String allText = "Omnivor";
  static String veganText = "Vegan";
  static String vegetarianText = "Vegetarisch";
  static String pescetarianText = "Pescetarisch";
  List<String> prefTexts = [allText, vegetarianText, veganText, pescetarianText];

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
            key: const Key("Omnivor_Checkbox"),
            activeColor: activeColor,
                  value: all,
                  onChanged: (bool? value) {
                    setState(() {
                     all = value!;
                     if (value){
                       vegan = vegetarian = pescetarian = false;
                       List <String> tmp = [...prefTexts];
                       SharedPrefs().setMultiplePref(tmp..remove(allText), !value);
                     }
                     SharedPrefs().setFoodPref(allText, value);
                    });
                  },
                )),
          const TileDivider(),
          WidgetTile(text: vegetarianText, info: Checkbox(
            key: const Key("Vegetarian_Checkbox"),
            activeColor: activeColor,
            value: vegetarian,
            onChanged: (bool? value) {
              setState(() {
                  vegetarian = value!;
                  if (value){
                    vegan = all = pescetarian = false;
                    List <String> tmp = [...prefTexts];
                    SharedPrefs().setMultiplePref(tmp..remove(vegetarianText), !value);
                  }
                  SharedPrefs().setFoodPref(vegetarianText, value);

              });
            },
          )),
          const TileDivider(),
          WidgetTile(text: veganText, info: Checkbox(
            key: const Key("Vegan_Checkbox"),
            activeColor: activeColor,
            value: vegan,
            onChanged: (bool? value) {
              setState(() {
                  vegan = value!;
                  if (value){
                    all = vegetarian = pescetarian = false;
                    List <String> tmp = [...prefTexts];
                    SharedPrefs().setMultiplePref(tmp..remove(veganText), !value);
                  }
                  SharedPrefs().setFoodPref(veganText, value);
              });
            },
          )),
          const TileDivider(),
          WidgetTile(text: pescetarianText, info: Checkbox(
            key: const Key("Pescetarian_Checkbox"),
            activeColor: activeColor,
            value: pescetarian,
            onChanged: (bool? value) {
              setState(() {
                  pescetarian = value!;
                  if (value){
                    vegan = vegetarian = all = false;
                    List <String> tmp = [...prefTexts];
                    SharedPrefs().setMultiplePref(tmp..remove(pescetarianText), !value);
                  }
                  SharedPrefs().setFoodPref(pescetarianText, value);
              });
            },
          )),
        ],
      )
    );
  }
}
