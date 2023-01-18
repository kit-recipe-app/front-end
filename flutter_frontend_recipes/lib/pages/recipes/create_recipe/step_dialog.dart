import 'package:flutter/material.dart';

class StepDialog extends StatefulWidget {

  final ValueSetter<String> addStep;
  const StepDialog({Key? key, required this.addStep}) : super(key: key);


  @override
  State<StepDialog> createState() => _StepDialogState();
}

class _StepDialogState extends State<StepDialog> {

  final TextEditingController _c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              minLines: 1,
              maxLines: 20,
              controller: _c,
              decoration: const InputDecoration(
                hintText: 'Beschreibung',
                labelText: 'Beschreibung:',
              ),
            ),
          ),
          TextButton(onPressed: () {
            widget.addStep(_c.text);
            Navigator.pop(context);
          } , child: Text("Speichern"))
        ],
      ),
    );
  }
}
