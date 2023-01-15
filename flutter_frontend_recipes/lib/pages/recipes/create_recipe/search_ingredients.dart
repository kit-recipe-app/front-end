import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../content_examples/ingredient_examples.dart';
import '../../../types/ingredient.dart';
import 'ingredient_builder.dart';

class SearchIngredients extends StatefulWidget {
  final ValueSetter<RAIngredient> addItem;
  const SearchIngredients({Key? key, required this.addItem}) : super(key: key);

  @override
  State<SearchIngredients> createState() => _SearchIngredientsState();
}

class _SearchIngredientsState extends State<SearchIngredients> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 40, 8,8),
        child: SearchableList<RAIngredient> (
          initialList: IngredientExamples.ingredients2,
          builder: (RAIngredient ing) => BuildIngredient(ingredient: ing, addItem: widget.addItem,),
          filter: (value) => IngredientExamples.ingredients2.where((element) => element.name.toLowerCase().contains(value)).toList(),
          inputDecoration: InputDecoration(
            labelText: "Zutaten",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
