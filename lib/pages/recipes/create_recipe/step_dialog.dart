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
      alignment: const Alignment(0,0.1),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SizedBox(
        height: 400,
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
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: () {
                widget.addStep(_c.text);
                Navigator.pop(context);
              } , child: const Text("Speichern",
                    style: TextStyle(color: Color(0xff66aa44), fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
