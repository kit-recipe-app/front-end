import 'package:flutter/material.dart';

class AccountTile extends StatefulWidget {

  final String text;
  String info;

  AccountTile({Key? key, required this.text, required this.info}) : super(key: key);

  @override
  State<AccountTile> createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(8),
          height: 55,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text),
              Text(widget.info, style: TextStyle(color: Colors.grey.shade600,))
            ],
          ),
        ),
      ),
    );
  }
}
