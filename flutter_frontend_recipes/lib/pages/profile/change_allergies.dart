import 'package:flutter/material.dart';

import '../../constants/color_styles.dart';
import '../../constants/font_styles.dart';
import '../../constants/icon_designs.dart';


class ChangeAllergies extends StatefulWidget {
  String listOfAllergies;
  ChangeAllergies({Key? key, required this.listOfAllergies }) : super(key: key);

  @override
  State<ChangeAllergies> createState() => _ChangeAllergiesState();
}

class _ChangeAllergiesState extends State<ChangeAllergies> {

  final textController = TextEditingController();
  String nameForNewList = '';
  String displayedText = '';

  String noNameInput = '';
  String changeAllergyText = 'Allergien anpassen';
  String changeAllergies = 'Änderungen übernehmen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40,),
          Center(
            child: Text(
              changeAllergyText,
              style: FontStyles.bigText,
            ),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    textController.clear();
                  },
                  icon: Icon(RecipeAppIcons.clearText),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Hier soll später das Backend eingebunden werden, um neue Einkaufslisten
              // TODO: zu den eigenen Hinzugefügt werden
              if (textController.text != '') {
                setState(() {
                  widget.listOfAllergies = textController.text;
                  Navigator.pop(context, widget.listOfAllergies);
                });
              } else if (textController.text == '') {
                setState(() {
                  displayedText = noNameInput;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: RecipeAppColorStyles.addButtonColor,
            ),
            child: Text(
              changeAllergies,
              style: FontStyles.normalText,
            ),
          ),



        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Abbrechen',
          style: FontStyles.bigText,
        ),
      ),
    );
  }
}



