import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List<String> units = ["g", "Stück", "ml", "kg", "Blatt"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
          color: Colors.white,
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
                      initialList: IngredientExamples.ingredients2,
                      builder: (RAIngredient ing) => BuildIngredient(
                        ingredient: ing,
                        addItem: widget.addItem,
                        showDialog: showAddDialog,
                      ),
                      filter: (value) => IngredientExamples.ingredients2
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
              backgroundColor: Colors.white,
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
                            style: TextStyle(fontSize: 20),
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

  showAddDialog2(RAIngredient ingredient) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState){
                return Dialog(
                  backgroundColor: Colors.white,
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

                              showModalBottomSheet<void>(
                            backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                Future.delayed(const Duration(seconds: 5), () { //asynchronous delay
                                  if (mounted) { //checks if widget is still active and not disposed
                                    setState(() { //tells the widget builder to rebuild again because ui has updated
                                      Navigator.pop(context); //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
                                    });
                                  }
                                });
                                /*var _timer = Timer(const Duration(milliseconds: 500), () {
                                  Navigator.pop(context);
                                });
                                Future.delayed(const Duration(milliseconds: 900),
                                    () {
                                  Navigator.pop(context);
                                });*/
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.7),
                                        spreadRadius: 10,
                                        blurRadius: 100,
                                        offset: Offset(0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 60,
                                  child: Center(child: Text("Zutat hinzugefügt", style: TextStyle(fontSize: 20),)),
                                );

                              });
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
