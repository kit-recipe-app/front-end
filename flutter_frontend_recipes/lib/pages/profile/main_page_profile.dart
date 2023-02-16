import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/setting-tile.dart';

import '../../constants/color_styles.dart';
import '../../constants/font_styles.dart';
import '../../constants/icon_designs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String title = 'Dein Profil';
  String name = "Johannes";
  String preference = "Vegetarier";
  String editProfile = "Profil bearbeiten";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: RecipeAppColorStyles.navigationBarSelectedIconColor,
          title: Text(
            title,
            style: FontStyles.appBarText,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
              child: Center(
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                        child: Icon(
                          RecipeAppIcons.profilePageIcon,
                          size: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: Text(
                                preference
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                child: Text(
                  editProfile, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SettingTile(text: 'Einstellungen',),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SettingTile(text: 'Präferenzen',),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SettingTile(text: 'Standard-Lebensmittel',),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SettingTile(text: 'Meine Rezepte',),
            ),
          ],
        ));
  }
}
