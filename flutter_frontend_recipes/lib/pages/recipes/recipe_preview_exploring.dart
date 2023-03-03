import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

class RecipeAppRecipePreviewExploring extends StatefulWidget {
  final RARecipe recipe;
  final bool own;
  final Function? delete;

  RecipeAppRecipePreviewExploring(
      {required this.recipe, super.key, required this.own, this.delete});

  @override
  State<RecipeAppRecipePreviewExploring> createState() => _RecipeAppRecipePreviewExploringState();
}

class _RecipeAppRecipePreviewExploringState extends State<RecipeAppRecipePreviewExploring> {
  @override
  Widget build(BuildContext context) {
    double width = !widget.own ? 200 : MediaQuery.of(context).size.width - 20;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeOverview(recipe: widget.recipe)),
        );
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.all(8),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: (widget.recipe.picture.startsWith('http'))
                  ? Image.network(
                      widget.recipe.picture,
                      width: width,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      widget.recipe.picture,
                      width: width,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                widget.recipe.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                widget.recipe.description,
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
            !widget.own
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: getIconBar(),
                  )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getIconBar(),
                getButtonBar(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getIconBar() {
    List<Widget> availableValues = [];
    if (widget.recipe.getCalories() != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.calories),
            Text(
              "${widget.recipe.getCalories()} kcal",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    if (widget.recipe.time != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.timeIcon),
            Text(
              "${widget.recipe.time} min.",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    if (widget.recipe.difficulty != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.difficultyIcon),
            Text(
              (widget.recipe.difficulty != null) ? widget.recipe.difficulty! : "",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    return !widget.own ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: availableValues,
    )
    : Container(
      width: (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width - 20) / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: availableValues,
      ),
    )
    ;
  }

  Widget getButtonBar(){
    return Material(
      color: Colors.transparent,
      child: Container(
        width: (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width - 20) / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              customBorder: CircleBorder(),
              child:Icon(Icons.delete),
              onTap: () {
                _showConfirmDialog();
              },
            ),
            InkWell(
              customBorder: CircleBorder(),
              child:Icon(Icons.edit),
              onTap: () {},
            ),
            InkWell(
              customBorder: CircleBorder(),
              child:widget.recipe.favorite ? Icon(Icons.star) : Icon(Icons.star_border),
              onTap: () {
                setState(() {
                  widget.recipe.favorite = !widget.recipe.favorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Rezept löschen"),
            content: const Text("Möchten Sie das Rezept wirklich löschen?"),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    widget.delete!();
                  });
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

}
