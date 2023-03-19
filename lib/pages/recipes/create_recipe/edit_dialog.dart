import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {
  final String oldString;

  const EditDialog({Key? key, required this.oldString}) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final TextEditingController _c = TextEditingController();

  @override
  void initState() {
    _c.text = widget.oldString;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: const Alignment(0, 0.1),
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
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, _c.text);
                  },
                  child: const Text("Speichern",
                      style: TextStyle(color: Color(0xff66aa44), fontSize: 20)),
                ))
          ],
        ),
      ),
    );
  }
}
