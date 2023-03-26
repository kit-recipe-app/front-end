import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../types/ingredient.dart';

/// A widget that represents a single ingredient item in a list of ingredients.
/// The item consists of the ingredient name, a text field for entering the amount,
/// a dropdown button for selecting the unit of measurement, and a delete button.
class IngredientListItem extends StatefulWidget {

  final List<String> units;
  final List<TextEditingController> controllers;
  List<RAIngredient> lis;
  RAIngredient ing;
  Function removeItem;

  IngredientListItem({Key? key, required this.units, required this.controllers, required this.ing, required this.removeItem, required this.lis}) : super(key: key);


  @override
  State<IngredientListItem> createState() => _IngredientListItemState();
}

class _IngredientListItemState extends State<IngredientListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.ing.name),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                    controller: widget.controllers[widget.lis.indexOf(widget.ing)],
                  ),
                ),
              ),
            ),
            DropdownButtonHideUnderline(
                child: DropdownButton2(
                  buttonWidth: 75,
                  items: widget.units.map((unit) =>
                      DropdownMenuItem<String>(value: unit, child: Text(unit))).toList(),
                  value: widget.ing.unit,
                  onChanged: (value) {
                    setState(() {
                      widget.ing.unit = value as String;
                    });
                  },
                )
            ),
            IconButton(
                onPressed: () => widget.removeItem(widget.ing, widget.lis.indexOf(widget.ing)),
                icon: const Icon(Icons.close))
          ],
        ),
      ),
    );
  }
}
