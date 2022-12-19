import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/font_styles.dart';
import '../../../constants/icon_designs.dart';


class ProfilPageSettingOptionCard extends StatelessWidget {
  final String title;
  final Widget page;
  ProfilPageSettingOptionCard({Key? key,
    required this.title, required this.page}) : super(key: key);


  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
            page
            ),
          );

        },
        title: Text(
          title,
          style: fontStyles.bigText,
        ),
        trailing: Icon(
            iconDesigns.settingIcon,
        ),
      ),
    );
  }
}


