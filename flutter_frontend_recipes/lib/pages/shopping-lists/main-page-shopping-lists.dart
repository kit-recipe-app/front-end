import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/colors.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/content_examples/initiating_examples.dart';



class MainPageShoppingLists extends StatefulWidget {
  const MainPageShoppingLists({Key? key}) : super(key: key);

  @override
  State<MainPageShoppingLists> createState() => _MainPageShoppingListsState();
}


class _MainPageShoppingListsState extends State<MainPageShoppingLists> {

  ColorDesigns colorDesigns = ColorDesigns();
  FontStyles fontStyles = FontStyles();
  IconDesigns iconDesigns = IconDesigns();

  String subTitleTiles = 'Erstellt am *Datum*';
  String title = 'Einkaufslisten';

  InitiatingExamples initiatingExamples = InitiatingExamples();


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
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
        child: Center(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: initiatingExamples.exampleLists.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    trailing:
                    Icon(
                        iconDesigns.notFinalIcon,
                      color: colorDesigns.unSelectedIconColor,
                      size: 20,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          initiatingExamples.exampleLists[index].title,
                          style: fontStyles.normalText,
                        ),
                         Text(
                          subTitleTiles,
                          style: fontStyles.subtitleForTiles,
                        ),
                      ],
                    ),
                    subtitle: Icon(iconDesigns.profilePageIcon),

                  ),
                );
              },
            ),
          ),
        ),
      ),

    );
  }
}



