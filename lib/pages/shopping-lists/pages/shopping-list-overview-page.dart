import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/content_examples/initiating_examples.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/page-components/create-content-lists.dart';

class ShoppingListOverview extends StatefulWidget {
  const ShoppingListOverview({Key? key}) : super(key: key);

  @override
  State<ShoppingListOverview> createState() => _ShoppingListOverviewState();
}

class _ShoppingListOverviewState extends State<ShoppingListOverview> {
  InitiatingExamples initiatingExamples = InitiatingExamples();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(35, 30, 35, 5),
        child: Center(
          child: Scrollbar(
            child: ListView(
              children:
              CreateContentLists().listsForOverview(
                allShoppingLists: initiatingExamples.exampleLists,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
