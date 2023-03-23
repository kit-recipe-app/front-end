import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class AddShoppingListScreen extends StatefulWidget {
  const AddShoppingListScreen({Key? key}) : super(key: key);

  @override
  _AddShoppingListScreenState createState() => _AddShoppingListScreenState();
}

class _AddShoppingListScreenState extends State<AddShoppingListScreen> {
  final _titleController = TextEditingController();
  bool titleMissing = false;

  void resetTitleMissing() {
    setState(() {
      titleMissing = false;
    });
  }

  bool _saveShoppingList() {
    final shoppingList = RAShoppingList(
      title: _titleController.text.trim(),
      creationDate: DateTime.now(),
    );
    return SharedPrefs().saveShoppingList(shoppingList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        title: Text(
          'Neue Einkaufsliste erstellen',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            RAInputField(
              hintText: "Titel",
              controller: _titleController,
              color:
                  (titleMissing) ? Colors.red.withOpacity(0.4) : Colors.black12,
              onNewFocus: resetTitleMissing,
            ),
            const SizedBox(
              height: 64,
            ),
            RAButton(
              onTap: () {
                if (_titleController.text.isEmpty) {
                  setState(() {
                    titleMissing = true;
                  });
                  return;
                }
                _saveShoppingList();
                Navigator.pop(context);
              },
              description: 'Speichern',
            ),
          ],
        ),
      ),
    );
  }
}
