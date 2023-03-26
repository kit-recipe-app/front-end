import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';

// animated navigation-switch to navigate in the recipe tab
class RecipeAppNavigationSwitchRecipes extends StatelessWidget {
  Function onChange; // function to be called when switch gets changed
  int selectedIndex; // current index
  RecipeAppNavigationSwitchRecipes(
      {required this.onChange, required this.selectedIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                GestureDetector(
                  key: const Key("Detector 0"),
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    onChange(0);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 32) / 2,
                    alignment: Alignment.center,
                    child: Text(
                      "Entdecken",
                      style: TextStyle(
                        color: (selectedIndex == 0)
                            ? RecipeAppColorStyles.selectedTextColor
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  key: const Key("Detector 1"),
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    onChange(1);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 32) / 2,
                    alignment: Alignment.center,
                    child: Text(
                      "Meine Rezepte",
                      style: TextStyle(
                        color: (selectedIndex == 1)
                            ? RecipeAppColorStyles.selectedTextColor
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
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
                ? 0
                : (MediaQuery.of(context).size.width - 32) / 2,
            child: Container(
              width: (MediaQuery.of(context).size.width - 32) / 2,
              height: 2,
              color: RecipeAppColorStyles.selectedTextColor,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 2,
              width: (MediaQuery.of(context).size.width - 32),
              child: Container(
                color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
