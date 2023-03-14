import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';

class RecipeAppSearchBar extends StatelessWidget {
  final bool withFilter;
  final Function onSearch;

  const RecipeAppSearchBar(
      {this.withFilter = true, super.key, required this.onSearch});

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
                SizedBox(
                  width: 300,
                  child: TextField(
                    onChanged: (String search){
                      onSearch(search);
                    },
                    decoration: InputDecoration(
                        hintText: "Search here",
                        contentPadding: EdgeInsets.all(2),
                        isDense: true,
                        border: InputBorder.none),
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
