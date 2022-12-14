import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/content_examples/initiating_examples.dart';
import 'package:flutter_frontend_recipes/pages/profile/profil-page-appbar.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile-sub-pages/setting-list.dart';

import 'current-profil-card.dart';
import 'example_profile.dart';

class ProfileMainPage extends StatelessWidget {
  ProfileMainPage({Key? key}) : super(key: key);

  final User? user = RAAuthService().user;
  late String? email = user?.email;

  Future<void> signOut() async {
    await RAAuthService().signOut();
  }

  Widget signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text("sign out"),
    );
  }

  ProfilPageOptions options = ProfilPageOptions();

  //TODO:hier später echtes Profil reinmachen
  Profile currentProfile = InitiatingExamples().exampleProfiles[0];

  // das hier muss irgendwie besser gemacht werden wegen Code Duplikate
  BuildProfiLAppBar buildProfiLAppBar = BuildProfiLAppBar();
  CurrentProfilCard currentProfilCard = CurrentProfilCard(
      currentProfile: InitiatingExamples().exampleProfiles[0]);
  //

  // wird später nicht mehr benötigt
  String meTab = 'Ich';
  String friendsTab = 'Freunde';
  //

  String changeProfile = 'Profil bearbeiten';
  String profilePageTitle = 'Profil';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: signOutButton(),
      appBar: buildProfiLAppBar.profilAppBar(profilePageTitle),
      body: Column(
        children: [
          // die SizedBox ist nur ein Platzhalter
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    meTab,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    friendsTab,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Container ist auch nur Platzhalter
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.green[700],
                height: 3,
                width: 150,
              ),
              Container(
                color: Colors.grey,
                height: 3,
                width: 150,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: currentProfilCard.returnCard(),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Text(
                  "Email:          ${user!.email!}",
                ),
              ),
            ],
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

          //
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 350,
              child: ListView(
                children: options.listOfOptions,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
