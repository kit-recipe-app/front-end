import 'package:flutter/material.dart';

/// Creates a [TileDivider] widget.
class TileDivider extends StatelessWidget {
  const TileDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the color of the divider based on the app's theme
    Color primaryColor = Theme.of(context).colorScheme.secondary;
    Color dividerColor = Colors.grey;
    if(primaryColor.value != Colors.white.value){
      dividerColor = Colors.white;
    }
    return Divider(thickness: 0.9, color: dividerColor, height: 0,);
  }
}
