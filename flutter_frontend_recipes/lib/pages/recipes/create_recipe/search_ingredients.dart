import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../types/ingredient.dart';
import 'ingredient_builder.dart';

/// A widget that allows users to search and select ingredients from a list.
///
/// Users can enter text in a search bar to filter the list of available ingredients.
/// They can also click on an ingredient to bring up a dialog box that allows them
/// to select an amount and unit for the ingredient. Once they have made their selection,
/// they can add the ingredient to their recipe by clicking on the "Hinzufügen" button.
class SearchIngredients extends StatefulWidget {
  final ValueSetter<RAIngredient> addItem;
  final List<RAIngredient> ingredientList;

  const SearchIngredients({Key? key, required this.addItem, required this.ingredientList}) : super(key: key);

  @override
  State<SearchIngredients> createState() => _SearchIngredientsState();
}

class _SearchIngredientsState extends State<SearchIngredients> {
  List<String> units = ["g", "Stück", "ml", "kg", "Blatt"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SafeArea(
          bottom: false,
          right: false,
          left: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: SearchableList<RAIngredient>(
                    initialList: widget.ingredientList,
                    builder: (RAIngredient ing) => BuildIngredient(
                      ingredient: ing,
                      showDialog: showAddDialog,
                    ),
                    filter: (value) => widget.ingredientList
                        .where((element) =>
                            element.name.toLowerCase().startsWith(value) ||
                            element.name.startsWith(value))
                        .toList(),
                    inputDecoration: InputDecoration(
                      labelText: "Zutaten",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1.0,
                        ),
                        /*focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1.0,
                        ),*/
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xff66aa44),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  child: const Text("Zurück"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAddDialog(RAIngredient ingredient) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState){
              return Dialog(
              alignment: const Alignment(0, -0.3),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${ingredient.name} hinzufügen",
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 70,
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
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                  ),
                                  onChanged: (text) {
                                    ingredient.amount = int.parse(text);
                                  },
                                ),
                              ),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                              child: DropdownButton2(
                            buttonWidth: 75,
                            items: units
                                .map((unit) => DropdownMenuItem<String>(
                                    value: unit, child: Text(unit)))
                                .toList(),
                            value: ingredient.unit,
                            onChanged: (value) {
                              setState(() {
                                ingredient.unit = value as String;
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          widget.addItem(ingredient);
                          Navigator.pop(context);
                          const snackBar = SnackBar(
                            duration: Duration(milliseconds: 1000),
                              margin: EdgeInsets.only(bottom: 60.0, left:10, right: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              dismissDirection: DismissDirection.none,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.black,
                              content: Text(
                            "Zutat hinzugefügt",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text("Hinzufügen",
                            style: TextStyle(
                                color: Color(0xff66aa44), fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            );}
          );
        });
  }
}
