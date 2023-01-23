import 'package:flutter/material.dart';

class ConfirmRecipe extends StatelessWidget {

  final Function() upload;
  const ConfirmRecipe({Key? key, required this.upload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Glückwunsch! Dein Rezept wurde erfolgreich erstellt!"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  upload();
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
      )
    );
  }
}
