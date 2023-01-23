import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';

import '../page-components/add-list-text-field.dart';

class AddShoppingList extends StatefulWidget {
  const AddShoppingList({Key? key}) : super(key: key);

  @override
  State<AddShoppingList> createState() => _AddShoppingListState();
}

class _AddShoppingListState extends State<AddShoppingList> {

  String giveName = 'Geben Sie ihrer Einkaufsliste bitte einen Namen';
  String create = 'Erstellen';

  final textController = TextEditingController();
  String nameForNewList = '';
  String displayedText = '';
  String noNameInput = 'Bitte geben Sie einen Namen an';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                giveName,
                style: FontStyles.bigText,
                textAlign: TextAlign.center,
              ),
            ),
            AddListTextField(textController: textController),
            ElevatedButton(
              onPressed: () {
                // TODO: Hier soll später das Backend eingebunden werden, um neue Einkaufslisten
                // TODO: zu den eigenen Hinzugefügt werden
                if (textController.text != '') {
                  setState(() {
                    nameForNewList = textController.text;
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
                create,
                style: FontStyles.normalText,
              ),
            ),
            Text(
              displayedText,
            ),
          ],
        ),
      ),
    );
  }
}
