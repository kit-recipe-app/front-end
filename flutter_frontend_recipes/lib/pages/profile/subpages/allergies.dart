import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/widget_tile.dart';

class Allergies extends StatefulWidget {
  const Allergies({Key? key}) : super(key: key);

  @override
  State<Allergies> createState() => _AllergiesState();
}

class _AllergiesState extends State<Allergies> {
  String title = "Allergien";
  bool nuts = false;
  bool milk = false;
  bool eggs = false;
  bool fish = false;
  bool gluten = false;
  bool seafood = false;
  String nutsText = "Nüsse";
  String milkText = "Milch";
  String eggsText = "Eier";
  String fishText = "Fisch";
  String glutenText = "Gluten";
  String seafoodText = "Meeresfrüchte";



  @override
  Widget build(BuildContext context) {
  Color activeColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.onSecondary),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: Column(
        children: [
          WidgetTile(text: nutsText, info: Switch(
            activeColor: activeColor,
            value: nuts,
            onChanged: (bool value) => setState(() => nuts = value),
          )),
          const TileDivider(),
          WidgetTile(text: eggsText, info: Switch(
            activeColor: activeColor,
            value: eggs,
            onChanged: (bool value) => setState(() => eggs = value),
          )),
          const TileDivider(),
          WidgetTile(text: milkText, info: Switch(
            activeColor: activeColor,
            value: milk,
            onChanged: (bool value) => setState(() => milk = value),
          )),
          const TileDivider(),
          WidgetTile(text: fishText, info: Switch(
            activeColor: activeColor,
            value: fish,
            onChanged: (bool value) => setState(() => fish = value),
          )),
          const TileDivider(),
          WidgetTile(text: glutenText, info: Switch(
            activeColor: activeColor,
            value: gluten,
            onChanged: (bool value) => setState(() => gluten = value),
          )),
          const TileDivider(),
          WidgetTile(text: seafoodText, info: Switch(
            activeColor: activeColor,
            value: seafood,
            onChanged: (bool value) => setState(() => seafood = value),
          )),
        ],
      ),
    );
  }
}
