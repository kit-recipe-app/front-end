import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/content_examples/initiating_examples.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/pages/shopping-list-content-page.dart';

class ShoppingListOverview extends StatefulWidget {
  const ShoppingListOverview({Key? key}) : super(key: key);

  @override
  State<ShoppingListOverview> createState() => _ShoppingListOverviewState();
}

class _ShoppingListOverviewState extends State<ShoppingListOverview> {
  String subTitleTiles = 'Erstellt am ';
  String title = 'Einkaufslisten';
  String member = 'Mitglieder: ';
  InitiatingExamples initiatingExamples = InitiatingExamples();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShoppingListContentPage(
                                  shoppingList:
                                      initiatingExamples.exampleLists[index])),
                        );
                      },
                      trailing: Icon(
                        RecipeAppIcons.chain,
                        color: RecipeAppColorStyles.unSelectedIconColor,
                        size: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              initiatingExamples.exampleLists[index].title,
                              style: FontStyles.titleText,
                            ),
                            Text(
                              '$subTitleTiles ${initiatingExamples.exampleLists[index].date}',
                              style: FontStyles.subtitleForTiles,
                            ),
                          ],
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            RecipeAppIcons.profilePageIcon,
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
    );
  }
}
