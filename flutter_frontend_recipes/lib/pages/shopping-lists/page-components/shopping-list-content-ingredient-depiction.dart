import 'package:flutter/material.dart';

import '../../recipes/example_ingredients.dart';


class IngredientDepiction {



  Widget createColumnForAllIngredients(List<Ingredients> allIngredients) {
    bool? isChecked = false;

    List<Widget> widgetList = [];
    for (var element in allIngredients) {
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              width: 100,
              child: Text(element.name),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              width: 50,
              child: Text('${element.amount}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              width: 50,
              child: Text(element.unit),
            ),
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Checkbox(
                    value: isChecked,
                    activeColor: Colors.green,
                    onChanged: (newBool) {
                      setState(() {
                        isChecked = newBool;
                      });
                    });
              })
        ],
      ));

      widgetList.add(Container(
        color: Colors.grey[400],
        height: 2,
        width: 300,
      ));
    }

    return Column(
      children: widgetList,
    );
  }


}
