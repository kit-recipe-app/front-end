import 'package:flutter/material.dart';

class SettingButton extends StatefulWidget {
  final String text;
  final Widget page;
  const SettingButton({Key? key, required this.text, required this.page}) : super(key: key);

  @override
  State<SettingButton> createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(35)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(widget.text, style: TextStyle(fontSize: 20),),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Icon(Icons.settings, size: 30,),
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => widget.page));
                },
                child: const SizedBox.shrink()),
          ),
        ),
      ],
    );
  }
}
