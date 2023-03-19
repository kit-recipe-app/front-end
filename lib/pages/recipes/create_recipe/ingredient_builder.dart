import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';

class BuildIngredient extends StatefulWidget {
  final RAIngredient ingredient;
  final Function(RAIngredient) showDialog;

  const BuildIngredient({Key? key, required this.ingredient, required this.showDialog}) : super(key: key);

  @override
  State<BuildIngredient> createState() => _BuildIngredientState();
}

class _BuildIngredientState extends State<BuildIngredient> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.ingredient.name),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                  onTap: (){
                    widget.showDialog(widget.ingredient);
                  },
              child: const SizedBox.shrink()),
            ),
          )
        ],
      ),
    );
  }
}
