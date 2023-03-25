import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/choice_dialog.dart';

/// A general, customizable SearchBar.
/// The 'controller' is used to show and set the input text.
class RecipeAppSearchBar extends StatelessWidget {
  final bool withFilter;// A boolean flag indicating whether the search bar includes a filter button.
  final Function onSearch;// Function that is called when the user types in the search bar.
  final Function onFilter;// Function that is called when the user taps the filter button.
  final String choice;// A string representing the chosen filter option.

  const RecipeAppSearchBar(
      {this.withFilter = true,
      super.key,
      required this.onSearch,
      required this.onFilter,
      required this.choice});

  /// Returns what is shown in the 'RecipeAppSearchBar'.
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
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
                Expanded(
                  child: TextField(
                    onChanged: (String search) {
                      onSearch(search);
                    },
                    decoration: const InputDecoration(
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
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              _dialogBuilder(context);
            },
            child: Icon(
              RecipeAppIcons.filerIcon,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }

  /// Shows a dialog box to select filter options when the filter button is tapped.
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChoiceDialog(
              title: "Filter",
              values: const ["Übersicht", "Alles", "Vegan", "Vegetarisch"],
              standard: choice,
              setText: onFilter);
        });
  }
}
