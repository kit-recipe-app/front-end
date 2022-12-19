import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';

import '../../constants/colors.dart';
import '../../constants/icon_designs.dart';


class MainFeed extends StatefulWidget {
  const MainFeed({Key? key}) : super(key: key);

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  String title = 'Willkommen';
  String favorites = 'Ihre Favoriten';
  String recommended = 'Ihre Empfehlungen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorDesigns.appBarBGColor,
        title: Text(
          title,
          style: fontStyles.appBarText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 30, 0, 10),
              child: Text(
                  favorites,
                style: fontStyles.titleText,
              ),
            ),
            const SizedBox(
              height: 110,
              child: Card(
                elevation: 2,
                child: ListTile(

                ),
              ),
            ),
            SizedBox(
              height: 130,
              child: Container(
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 20, 0, 10),
              child: Text(
                recommended,
                style: fontStyles.titleText,
              ),
            ),
            const SizedBox(
              height: 110,
              child: Card(
                elevation: 2,
                child: ListTile(

                ),
              ),
            ),
          ],
        ),
      ),



    );
  }
}



