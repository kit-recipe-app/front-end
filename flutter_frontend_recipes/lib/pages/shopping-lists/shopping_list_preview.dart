import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list_overview.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/shopping_list.dart';

/// Widget displaying a preview of a shopping List
/// (title, creationDate, itemAmount, favoriteFlag)
class ShoppingListPreview extends StatefulWidget {
  final RAShoppingList shoppingList; // The shopping list to be showed
  final Function reLoadRecipes; // Function, used to reload the ShoppingListMainPage
  const ShoppingListPreview(
      {required this.shoppingList, required this.reLoadRecipes, super.key});

  @override
  State<ShoppingListPreview> createState() => _ShoppingListPreviewState();
}

class _ShoppingListPreviewState extends State<ShoppingListPreview> {
  /// Returns a Widget that contains the title of the shopping list
  /// and the date it was created.
  Widget getHeading() {
    String year = widget.shoppingList.creationDate.year.toString();
    String month = widget.shoppingList.creationDate.month.toString();
    String day = widget.shoppingList.creationDate.day.toString();
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.shoppingList.title,
            overflow: TextOverflow.ellipsis,
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
      ),
    );
  }

  /// Returns a Text displaying the amount of items stored in the list
  Widget getBottomInfo() {
    String amountItems = widget.shoppingList.getItemAmount().toString();
    return Text(
      (amountItems == "0")
          ? "noch nichts hinzugefügt"
          : (amountItems == "1")
              ? "1 Gegenstand"
              : "$amountItems Gegenstände",
      style: const TextStyle(
        fontSize: 10,
      ),
    );
  }

  /// The button used to change the favoriteFlag of the shopping list
  Widget getFavouriteButton() {
    return InkWell(
      key: const Key("ShoppingListsFavoriteButton"),
      onTap: () {
        _updateShoppingList();
        widget.reLoadRecipes();
      },
      child: Icon(
        key: const Key("ShoppingListsFavoriteButtonIcon"),
        widget.shoppingList.favourite ? Icons.star : Icons.star_border,
        color: Colors.yellow,
      ),
    );
  }

  /// Uses SharedPrefs-Class to update the shopping list
  void _updateShoppingList() {
    final shoppingList = RAShoppingList(
      title: widget.shoppingList.title,
      creationDate: widget.shoppingList.creationDate,
      items: widget.shoppingList.items,
      favourite: !widget.shoppingList.favourite,
    );
    SharedPrefs().updateShoppingList(shoppingList);
  }

  /// returns what is shown in 'hoppingListPreview'
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key("ShoppingListDetector"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RAShoppingListOverview(
                    key: Key("${widget.shoppingList.title} Overview"),
                    shoppingList: widget.shoppingList,
                  )),
        ).then(((value) => widget.reLoadRecipes()));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        height: 112,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
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
                //const Text("test"), //TODO
                getBottomInfo(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
