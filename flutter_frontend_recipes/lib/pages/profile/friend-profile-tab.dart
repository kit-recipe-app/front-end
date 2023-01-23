import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile-page-components/current-profil-card.dart';

import '../../content_examples/initiating_examples.dart';


class FriendProfilesTab extends StatefulWidget {
  const FriendProfilesTab({Key? key}) : super(key: key);

  @override
  State<FriendProfilesTab> createState() => _FriendProfilesTabState();
}

class _FriendProfilesTabState extends State<FriendProfilesTab> {


  //TODO:hier später echtes Profil reinmachen
  CurrentProfilCard currentProfilCard = CurrentProfilCard(
      currentProfile: InitiatingExamples().exampleProfiles[1]);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: currentProfilCard.returnCard(),
        ),
      ],
    );
  }
}


