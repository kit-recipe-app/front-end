import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';

class RecipeAppSearchBar extends StatelessWidget {
  final bool withFilter;
  const RecipeAppSearchBar({this.withFilter = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Icon(
                    RecipeAppIcons.searchIcon,
                    size: 26,
                  ),
                ),
                const Text(
                  "Search here",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: withFilter,
          child: Icon(
            RecipeAppIcons.filerIcon,
            size: 26,
          ),
        ),
      ],
    );
  }
}
