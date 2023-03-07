import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class AddShoppingListScreen extends StatefulWidget {
  const AddShoppingListScreen({Key? key}) : super(key: key);

  @override
  _AddShoppingListScreenState createState() => _AddShoppingListScreenState();
}

class _AddShoppingListScreenState extends State<AddShoppingListScreen> {
  final _titleController = TextEditingController();
  final _itemControllers = <RAIngredient>[];
  bool titleMissing = false;

  void resetTitleMissing() {
    setState(() {
      titleMissing = false;
    });
  }

  void _addItem() {
    setState(() {
      _itemControllers.add(RAIngredient(
        name: '',
        unit: '',
        amount: 0,
        calories: 0,
      ));
    });
  }

  bool _saveShoppingList() {
    final shoppingList = RAShoppingList(
      title: _titleController.text.trim(),
      creationDate: DateTime.now(),
      //items: _itemControllers.isNotEmpty ? _itemControllers : null,
    );
    for (RAIngredient item in _itemControllers) {
      shoppingList.addItem(item);
    }
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
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            RAInputField(
              hintText: "Titel",
              controller: _titleController,
              color:
                  (titleMissing) ? Colors.red.withOpacity(0.4) : Colors.black12,
              onNewFocus: resetTitleMissing,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Items',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            ..._itemControllers.map((controller) => _buildItem(controller)),
            TextButton(
              onPressed: _addItem,
              child: const Text('Add Item'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isEmpty) {
                  setState(() {
                    titleMissing = true;
                  });
                  return;
                }
                _saveShoppingList();
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(RAIngredient controller) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
          initialValue: controller.name,
          onChanged: (value) => controller.name = value,
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Amount',
          ),
          initialValue: controller.amount.toString(),
          keyboardType: TextInputType.number,
          onChanged: (value) => controller.amount = int.tryParse(value) ?? 0,
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Unit',
          ),
          initialValue: controller.unit,
          onChanged: (value) => controller.unit = value,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
