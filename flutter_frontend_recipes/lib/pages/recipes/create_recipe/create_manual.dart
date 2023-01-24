import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/create_recipe_title.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/edit_dialog.dart';
import 'package:flutter_frontend_recipes/pages/recipes/create_recipe/step_dialog.dart';

import 'create_recipe_progress.dart';

class CreateManual extends StatefulWidget {

  final Function(List<String>) setManual;
  final Function() next;
  final Function() back;

  const CreateManual({Key? key, required this.setManual, required this.next, required this.back, })
      : super(key: key);

  @override
  State<CreateManual> createState() => _CreateManualState();
}

class _CreateManualState extends State<CreateManual> {
  String? selectedValueSingleDialog;
  List<String> steps = [];

  //widget.name übergeben

  addStep(String str) {
    setState(() {
      steps.add(str);
    });
  }

  removeStep(String str) {
    setState(() {
      steps.remove(str);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          widget.back();
        });
        return Future.value(false);
      },
      child: Material(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Stack(children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.back();
                  });

                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.black,
                  shadows: [Shadow(color: Colors.black, blurRadius: 1.0)],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Progress(total: 4, current: 3),
              ),
            ]),
          ),
          const RecipeTitle(name: "Verrate uns, wie man dein Rezept zubereitet"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return StepDialog(addStep: addStep);
                      }
                  );
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StepDialog(
                              addStep: addStep,
                            )),
                  );*/
                },
                child: const Text("Neuer Schritt"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          for (String step in steps)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${steps.indexOf(step) + 1}.$step",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _edit(context, steps.indexOf(step), step);
                          });
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () => removeStep(step),
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.setManual(steps);
                    widget.next();
                  });

                },
                child: const Text("Nächster Schritt"),
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color(0xff66aa44),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      )),
    );
  }

  Future<void> _edit(BuildContext context, int index, String oldString) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDialog(oldString: oldString)),
    );

    if (!mounted) return;
    setState(() {
      steps[index] = result;
    });
  }
}
