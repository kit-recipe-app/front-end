import 'package:flutter/material.dart';

import '../../../constants/font_styles.dart';
import '../../../constants/icon_designs.dart';

class ProfilPageSettingOptionCard extends StatelessWidget {
  final String title;
  final Widget page;
  const ProfilPageSettingOptionCard(
      {Key? key, required this.title, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        title: Text(
          title,
          style: FontStyles.bigText,
        ),
        trailing: Icon(
          RecipeAppIcons.settingIcon,
        ),
      ),
    );
  }
}
