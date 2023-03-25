import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/widget_tile.dart';

import '../../../shared/shared_prefs.dart';

class Allergies extends StatefulWidget {
  const Allergies({Key? key}) : super(key: key);

  @override
  State<Allergies> createState() => _AllergiesState();
}

class _AllergiesState extends State<Allergies> {
  String title = "Allergien";
  bool nuts = SharedPrefs().getAllergy(nutsText);
  bool milk = SharedPrefs().getAllergy(milkText);
  bool eggs = SharedPrefs().getAllergy(eggsText);
  bool fish = SharedPrefs().getAllergy(fishText);
  bool gluten = SharedPrefs().getAllergy(glutenText);
  bool seafood = SharedPrefs().getAllergy(seafoodText);
  static String nutsText = "Nüsse";
  static String milkText = "Milch";
  static String eggsText = "Eier";
  static String fishText = "Fisch";
  static String glutenText = "Gluten";
  static String seafoodText = "Meeresfrüchte";

  @override
  Widget build(BuildContext context) {
    Color activeColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: BackButton(
            key: const Key("BackButton"),
            color: Theme.of(context).colorScheme.onSecondary),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: Column(
        children: [
          WidgetTile(
              text: nutsText,
              info: Switch(
                  key: const Key("NutsSwitch"),
                  activeColor: activeColor,
                  value: nuts,
                  onChanged: (bool value) {
                    setState(() => nuts = value);
                    SharedPrefs().setAllergy(nutsText, value);
                  })),
          const TileDivider(),
          WidgetTile(
              text: eggsText,
              info: Switch(
                  key: const Key("EggsSwitch"),
                  activeColor: activeColor,
                  value: eggs,
                  onChanged: (bool value) {
                    setState(() => eggs = value);
                    SharedPrefs().setAllergy(eggsText, value);
                  })),
          const TileDivider(),
          WidgetTile(
              text: milkText,
              info: Switch(
                  key: const Key("MilkSwitch"),
                  activeColor: activeColor,
                  value: milk,
                  onChanged: (bool value) {
                    setState(() => milk = value);
                    SharedPrefs().setAllergy(milkText, value);
                  })),
          const TileDivider(),
          WidgetTile(
              text: fishText,
              info: Switch(
                  key: const Key("FishSwitch"),
                  activeColor: activeColor,
                  value: fish,
                  onChanged: (bool value) {
                    setState(() => fish = value);
                    SharedPrefs().setAllergy(fishText, value);
                  })),
          const TileDivider(),
          WidgetTile(
              text: glutenText,
              info: Switch(
                  key: const Key("GlutenSwitch"),
                  activeColor: activeColor,
                  value: gluten,
                  onChanged: (bool value) {
                    setState(() => gluten = value);
                    SharedPrefs().setAllergy(glutenText, value);
                  })),
          const TileDivider(),
          WidgetTile(
              text: seafoodText,
              info: Switch(
                  key: const Key("SeafoodSwitch"),
                  activeColor: activeColor,
                  value: seafood,
                  onChanged: (bool value) {
                    setState(() => seafood = value);
                    SharedPrefs().setAllergy(seafoodText, value);
                  })),
        ],
      ),
    );
  }
}
