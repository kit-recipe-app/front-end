import 'package:flutter/material.dart';

import '../../../constants/icon_designs.dart';


class AddListTextField extends StatefulWidget {
  final textController;
  const AddListTextField({Key? key, required this.textController}) : super(key: key);

  @override
  State<AddListTextField> createState() => _AddListTextFieldState();
}

class _AddListTextFieldState extends State<AddListTextField> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: widget.textController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {
              widget.textController.clear();
            },
            icon: Icon(RecipeAppIcons.clearText),
          ),
        ),
      ),
    );
  }
}

