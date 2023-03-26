import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/recipes/recipe_overview.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/types/recipe.dart';

import 'create_recipe/create_recipe_main_page.dart';

class RecipeAppRecipePreviewExploring extends StatefulWidget {
  final RARecipe recipe;
  final bool own;
  final bool search;
  final Function? delete;
  final Function? favorite;

  const RecipeAppRecipePreviewExploring(
      {required this.recipe,
      super.key,
      required this.own,
      this.delete,
      this.favorite,
      required this.search});

  @override
  State<RecipeAppRecipePreviewExploring> createState() =>
      _RecipeAppRecipePreviewExploringState();
}

class _RecipeAppRecipePreviewExploringState
    extends State<RecipeAppRecipePreviewExploring> {
  @override
  void initState() {
    widget.recipe.favorite =
        SharedPrefs().getFavorite(widget.recipe.id) ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = !widget.own
        ? (widget.search ? MediaQuery.of(context).size.width - 20 : 200)
        : MediaQuery.of(context).size.width - 20;
    return GestureDetector(
      key: const Key("OverviewDetector"),
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
            !widget.own
                ? Stack(
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
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            key: const Key("StarInkWell"),
                            customBorder: const CircleBorder(),
                            child: widget.recipe.favorite
                                ? const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black, blurRadius: 32.0)
                                    ],
                                  )
                                : const Icon(
                                    Icons.star_border,
                                    color: Colors.yellow,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black, blurRadius: 32.0)
                                    ],
                                  ),
                            onTap: () {
                              setState(() {
                                widget.recipe.favorite =
                                    !widget.recipe.favorite;
                                SharedPrefs().setFavorite(
                                    widget.recipe.id, widget.recipe.favorite);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : ClipRRect(
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
              padding: widget.own
                  ? const EdgeInsets.fromLTRB(15, 10, 8, 0)
                  : const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
              padding: widget.own
                  ? const EdgeInsets.fromLTRB(15, 5, 8, 0)
                  : const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
    if (widget.recipe.calories != null) {
      availableValues.add(
        Column(
          children: [
            Icon(RecipeAppIcons.calories),
            Text(
              "${widget.recipe.calories} kcal",
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
              (widget.recipe.difficulty != null)
                  ? widget.recipe.difficulty!
                  : "",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    return !widget.own
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: availableValues,
          )
        : SizedBox(
            width: (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                        .size
                        .width -
                    20) /
                2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: availableValues,
            ),
          );
  }

  Widget getButtonBar() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .width -
                20) /
            2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              child: const Icon(Icons.delete),
              onTap: () {
                _showConfirmDialog();
              },
            ),
            InkWell(
              key: const Key("ButtonBarStar"),
              customBorder: const CircleBorder(),
              child: const Icon(Icons.edit),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateRecipeMainPage(
                            edit: true,
                            oldRecipe: widget.recipe,
                          )),
                );
              },
            ),
            InkWell(
              customBorder: const CircleBorder(),
              child: widget.recipe.favorite
                  ? const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  : const Icon(
                      Icons.star_border,
                      color: Colors.yellow,
                    ),
              onTap: () {
                setState(() {
                  widget.recipe.favorite = !widget.recipe.favorite;
                  SharedPrefs()
                      .setFavorite(widget.recipe.id, widget.recipe.favorite);
                  widget.favorite!();
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
                child: const Text('OK'),
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
