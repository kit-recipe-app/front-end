import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/content_examples/initiating_examples.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/current-profile-tab.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/friend-profile-tab.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/profile-page-components/navigation.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/profile-page-components/profil-page-appbar.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/profile-sub-pages/setting-list.dart';

import 'current-profil-card.dart';
import 'example_profile.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({Key? key}) : super(key: key);

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {

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

  int currentIndex = 0;
  String changeProfile = 'Profil bearbeiten';
  String profilePageTitle = 'Profil';

  List<Widget> allTabs = [
    CurrentProfileTab(),
    FriendProfilesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: signOutButton(),
      appBar: buildProfiLAppBar.profilAppBar(profilePageTitle),
      body: Column(
        children: [
          // die SizedBox ist nur ein Platzhalter
          RecipeAppNavigationSwitchBasicLayout(
            selectedIndex: currentIndex,
            onChange: ((int index) {
              setState(() {
                currentIndex = index;
              });
            }),
            textLeftTab: meTab,
            textRightTab: friendsTab,
          ),

          allTabs[currentIndex],
        ],
      ),
    );
  }
}
