import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/example_profile.dart';

import '../../../constants/font_styles.dart';
import '../../../constants/icon_designs.dart';


class CurrentProfilCard {

  Profile currentProfile;

  CurrentProfilCard({ required this.currentProfile}) {
  }

  String vegetarian = 'Vegetarier';
  String noVegetarian = 'Standard mit Fleisch';

  String allergiesAndPreferencesToText() {
    String description = '';
    if (currentProfile.vegetarian) {
      description += vegetarian;
    }
    else {
      description += noVegetarian;
    }


    return description;
  }


  Card returnCard() {

    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(
            RecipeAppIcons.profilePageIcon,
          size: 50,
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
          child: Text(
            currentProfile.name,
            style: FontStyles.bigText,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              allergiesAndPreferencesToText(),
              style: FontStyles.subtitleForTiles,
            ),
            const SizedBox(height: 40),
          ],
        ),
        trailing: Text(
          currentProfile.levelOfCooking,
          style: FontStyles.subtitleForTiles,
        ),
      ),
    );
  }


}


