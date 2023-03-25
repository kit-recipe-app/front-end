import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/types/ingredient.dart';

class RAShoppingListItemOverview extends StatelessWidget {
  RAIngredient item;
  Function updateShoppingListIngredientDone;
  Function onLongPress;
  RAShoppingListItemOverview(
      {required this.item,
      required this.updateShoppingListIngredientDone,
      required this.onLongPress,
      super.key});

  Widget getTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${item.amount} ${item.unit}",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          key: const Key("ShoppingListsItemDoneButton"),
          onTap: () {
            //item.done = !item.done;
            updateShoppingListIngredientDone(item);
          },
          child: Icon(
            key: const Key("ShoppingListsItemDoneButtonIcon"),
            item.done ? Icons.check_box : Icons.check_box_outline_blank,
          ),
        )
      ],
    );
  }

  Widget getBottomRow(context) {
    return (item.recipe == null) ? Container() : getRecipeLink(context);
  }

  Widget getRecipeLink(context) {
    return InkWell(
      key: const Key("RecipeLink"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeOverview(recipe: item.recipe!)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffcbd5e0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          item.recipe!.title,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xffcbd5e0),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key("LongPressDetector"),
      onLongPress: () => onLongPress(),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTopRow(),
              getBottomRow(context),
            ],
          ),
        ),
      ),
    );
  }
}
