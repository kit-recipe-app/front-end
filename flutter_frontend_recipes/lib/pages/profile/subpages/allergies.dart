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
    Color primaryColor = Theme.of(context).colorScheme.onPrimary;
    Color secondaryColor = Theme.of(context).colorScheme.onBackground;
    Color opacityColor = Colors.grey.shade700;
    if(primaryColor.value == Colors.white.value){
      opacityColor = primaryColor.withOpacity(0.9);
    }
    return Scaffold(
      backgroundColor: opacityColor,
      appBar: AppBar(
        leading: BackButton(color: secondaryColor),
        backgroundColor: primaryColor,
        title: Text(
          title,
          style: TextStyle(color: secondaryColor),
        ),
      ),
      body: Column(
        children: [
          WidgetTile(text: nutsText, info: Switch(
            value: nuts,
            onChanged: (bool value) => setState(() => nuts = value),
          )),
          const TileDivider(),
          WidgetTile(text: eggsText, info: Switch(
            value: eggs,
            onChanged: (bool value) => setState(() => eggs = value),
          )),
          const TileDivider(),
          WidgetTile(text: milkText, info: Switch(
            value: milk,
            onChanged: (bool value) => setState(() => milk = value),
          )),
          const TileDivider(),
          WidgetTile(text: fishText, info: Switch(
            value: fish,
            onChanged: (bool value) => setState(() => fish = value),
          )),
          const TileDivider(),
          WidgetTile(text: glutenText, info: Switch(
            value: gluten,
            onChanged: (bool value) => setState(() => gluten = value),
          )),
          const TileDivider(),
          WidgetTile(text: seafoodText, info: Switch(
            value: seafood,
            onChanged: (bool value) => setState(() => seafood = value),
          )),
        ],
      ),
    );
  }
}
