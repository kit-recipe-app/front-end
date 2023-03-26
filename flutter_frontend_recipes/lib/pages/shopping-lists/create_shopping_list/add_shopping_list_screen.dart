import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

/// Page that is shown when the user creates a new shopping-list.
/// The user can input a title and then save the List locally
class AddShoppingListScreen extends StatefulWidget {
  const AddShoppingListScreen({Key? key}) : super(key: key);

  @override
  AddShoppingListScreenState createState() => AddShoppingListScreenState();
}

@visibleForTesting
class AddShoppingListScreenState extends State<AddShoppingListScreen> {
  final _titleController = TextEditingController(); // Controller of the input title
  bool titleMissing = false; // Flag showing if no title is given

  /// Sets the 'titleMissing' flag to false.
  /// Triggered when User taps the titleInputField.
  void resetTitleMissing() {
    setState(() {
      titleMissing = false;
    });
  }

  /// creates a new RAShoppingList object using the entered title and
  /// the current date and time, and saves it to the device's local 
  /// storage using the SharedPrefs utility class.
  bool _saveShoppingList() {
    final shoppingList = RAShoppingList(
      title: _titleController.text.trim(),
      creationDate: DateTime.now(),
    );
    return SharedPrefs().saveShoppingList(shoppingList);
  }

  /// Returns what is shown in 'AddShoppingListScreen'.
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
              key: const Key('NewShoppingListTitleInput'),
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
              key: const Key("NewShoppingListSaveButton"),
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
