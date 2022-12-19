import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';

class RecipeAppNavigationSwitchRecipes extends StatelessWidget {
  Function onChange;
  int selectedIndex;
  RecipeAppNavigationSwitchRecipes(
      {required this.onChange, required this.selectedIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    onChange(0);
                  },
                  child: Text(
                    "Entdecken",
                    style: TextStyle(
                      color: (selectedIndex == 0)
                          ? RecipeAppColorStyles.selectedTextColor
                          : RecipeAppColorStyles.unSelectedTextColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onChange(1);
                  },
                  child: Text(
                    "Meine Rezepte",
                    style: TextStyle(
                      color: (selectedIndex == 1)
                          ? RecipeAppColorStyles.selectedTextColor
                          : RecipeAppColorStyles.unSelectedTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            bottom: 0,
            left: (selectedIndex == 0)
                ? 8
                : (MediaQuery.of(context).size.width - 32) / 2 + 8,
            child: Container(
              width: (MediaQuery.of(context).size.width - 32) / 2,
              height: 2,
              color: RecipeAppColorStyles.selectedTextColor,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 8,
            child: SizedBox(
              height: 2,
              width: (MediaQuery.of(context).size.width - 32),
              child: Container(
                color: Colors.black12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
