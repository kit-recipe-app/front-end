import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/colors.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';


class AddShoppingList extends StatefulWidget {
  const AddShoppingList({Key? key}) : super(key: key);

  @override
  State<AddShoppingList> createState() => _AddShoppingListState();
}

class _AddShoppingListState extends State<AddShoppingList> {

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  String giveName = 'Geben Sie ihrer Einkaufsliste bitte einen Namen';
  String create = 'erstellen';

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(15),
              child: Text(
                giveName,
                style: fontStyles.bigText,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      textController.clear();
                    },
                    icon: Icon(iconDesigns.clearText),

                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {

            },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorDesigns.addButtonColor,
              ),
              child: Text(
                    create,
                style: fontStyles.normalText,
                ),

            )
          ],
        ),
      ),
    );
  }
}


