import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/store_shopping_lists_locally/local_storing.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
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

  Future<void> _saveShoppingList() async {
    final shoppingList = RAShoppingList(
      title: _titleController.text.trim(),
      creationDate: DateTime.now(),
      items: _itemControllers.isNotEmpty ? _itemControllers : null,
    );
    await LocalStorage().saveShoppingList(shoppingList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Shopping List'),
      ),
      floatingActionButton: RAButton(
        onTap: () {
          LocalStorage().wipeData();
        },
        description: "alle Listen löschen",
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              'Items',
              style: Theme.of(context).textTheme.subtitle1,
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
                _saveShoppingList();
                Navigator.pop(context);
              },
              child: const Text('Save'),
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
