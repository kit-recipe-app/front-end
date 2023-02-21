import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/new_shopping_list_overview.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

class NewShoppingListPreview extends StatefulWidget {
  final RAShoppingList shoppingList;
  const NewShoppingListPreview({required this.shoppingList, super.key});

  @override
  State<NewShoppingListPreview> createState() => _NewShoppingListPreviewState();
}

class _NewShoppingListPreviewState extends State<NewShoppingListPreview> {
  Widget getHeading() {
    String year = widget.shoppingList.creationDate.year.toString();
    String month = widget.shoppingList.creationDate.month.toString();
    String day = widget.shoppingList.creationDate.day.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.shoppingList.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          "Erstellt am $day.$month.$year",
          style: const TextStyle(
            color: Color(0xff6b7280),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget getBottomInfo() {
    String amountItems = widget.shoppingList.getItemAmount().toString();
    return Text(
      (amountItems == "0")
          ? "noch nichts hinzugefügt"
          : "$amountItems Gegenstände",
      style: const TextStyle(
        fontSize: 10,
      ),
    );
  }

  Widget getFavouriteButton() {
    return InkWell(
      onTap: () {
        setState(() {
          widget.shoppingList.favourite = !widget.shoppingList.favourite;
        });
      },
      child: Icon(
        widget.shoppingList.favourite ? Icons.star : Icons.star_border,
        color: Colors.yellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RAShoppingListOverview(shoppingList: widget.shoppingList)),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        height: 112,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeading(),
                getFavouriteButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("test"), //TODO
                getBottomInfo(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
