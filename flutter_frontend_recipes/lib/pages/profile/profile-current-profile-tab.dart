import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile-page-components/current-profil-card.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile-sub-pages/setting-list.dart';

import '../../constants/font_styles.dart';
import '../../content_examples/initiating_examples.dart';


class CurrentProfileTab extends StatefulWidget {
  const CurrentProfileTab({Key? key}) : super(key: key);

  @override
  State<CurrentProfileTab> createState() => _CurrentProfileTabState();
}

class _CurrentProfileTabState extends State<CurrentProfileTab> {

  ProfilPageOptions options = ProfilPageOptions();

  //TODO:hier später echtes Profil reinmachen
  CurrentProfilCard currentProfilCard = CurrentProfilCard(
      currentProfile: InitiatingExamples().exampleProfiles[0]);

  String changeProfile = 'Profil bearbeiten';


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: currentProfilCard.returnCard(),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 10, 20),
              child: Text(
                changeProfile,
                style: FontStyles.titleText,
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 220,
            child: ListView(
              children: options.listOfOptions,
            ),
          ),
        ),
      ],
    );
  }
}

