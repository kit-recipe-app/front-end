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
      child: Column(
        children: [
          TextField(
            minLines: 1,
            maxLines: 20,
            controller: _c,
            decoration: const InputDecoration(
              hintText: 'Beschreibung',
              labelText: 'Beschreibung:',
            ),
          ),
          TextButton(onPressed: () {
            Navigator.pop(context, _c.text);
          } , child: Text("Speichern"))
        ],
      ),
    );
  }
}
