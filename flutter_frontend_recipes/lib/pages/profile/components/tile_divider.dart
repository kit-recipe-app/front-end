import 'package:flutter/material.dart';

class TileDivider extends StatelessWidget {
  const TileDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.onPrimary;
    Color dividerColor = Colors.grey;
    if(primaryColor.value != Colors.white.value){
      dividerColor = Colors.white;
    }
    return Divider(thickness: 0.9, color: dividerColor, height: 0,);
  }
}
