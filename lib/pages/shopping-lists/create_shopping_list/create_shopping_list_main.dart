import 'dart:ui';

import 'package:flutter/material.dart';

class CreateShoppingList extends StatefulWidget {
  const CreateShoppingList({super.key});

  @override
  State<CreateShoppingList> createState() => _CreateShoppingListState();
}

class _CreateShoppingListState extends State<CreateShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Neue Einkaufsliste erstellen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
