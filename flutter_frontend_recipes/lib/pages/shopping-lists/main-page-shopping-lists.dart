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

  String subTitleTiles = 'Erstellt am ';
  String title = 'Einkaufslisten';
  String member = 'Mitglieder: ';
  String addNewList = 'Liste erstellen';
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
        padding: const EdgeInsets.fromLTRB(35, 30, 35, 5),
        child: Center(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: initiatingExamples.exampleLists.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 4, 5, 4),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      trailing: Icon(
                        iconDesigns.notFinalIcon,
                        color: colorDesigns.unSelectedIconColor,
                        size: 20,
                      ),

                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              initiatingExamples.exampleLists[index].title,
                              style: fontStyles.titleText,
                            ),
                             Text(
                               '$subTitleTiles ${initiatingExamples.exampleLists[index].date}',
                              style: fontStyles.subtitleForTiles,
                            ),
                          ],
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            iconDesigns.profilePageIcon,
                            size: 25,
                          ),
                        ],
                      ),

                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      SizedBox( width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorDesigns.addButtonColor,
          ),
          onPressed: () {

          },
          child: Text(
            addNewList,
            style: fontStyles.normalText,
          ),
        ),
      ),

    );
  }
}



