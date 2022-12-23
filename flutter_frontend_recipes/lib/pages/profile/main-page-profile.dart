import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile-current-profile-tab.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile-friend-profile-tab.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile-page-components/profil-page-appbar.dart';


import '../recipes/navigation-switch-recipes.dart';


class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({Key? key}) : super(key: key);

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {

  //TODO:hier später echtes Profil reinmachen
  // das hier muss irgendwie besser gemacht werden wegen Code Duplikate
  BuildProfiLAppBar buildProfiLAppBar = BuildProfiLAppBar();
  //


  String meTab = 'Ich';
  String friendsTab = 'Freunde';

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
      appBar: buildProfiLAppBar.profilAppBar(profilePageTitle),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
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
              ],
            ),
          ),

          allTabs[currentIndex],

        ],
      ),
    );
  }
}
