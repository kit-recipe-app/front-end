import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';

class BuildIngredient extends StatefulWidget {
  final RAIngredient ingredient;
  final ValueSetter<RAIngredient> addItem;

  const BuildIngredient({Key? key, required this.ingredient, required this.addItem}) : super(key: key);

  @override
  State<BuildIngredient> createState() => _BuildIngredientState();
}

class _BuildIngredientState extends State<BuildIngredient> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
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
            IconButton(onPressed: () => widget.addItem(widget.ingredient), icon: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
