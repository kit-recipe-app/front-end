import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/setting_button.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/account_settings.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/allergies.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/app_settings.dart';
import 'package:flutter_frontend_recipes/pages/profile/subpages/preferences.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';

import '../../authentification/auth.dart';
import '../../backend_connection/loader.dart';
import '../../constants/color_styles.dart';
import '../../constants/font_styles.dart';
import '../../constants/icon_designs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Loader loader = Loader();
  String title = 'Dein Profil';
  String preference = SharedPrefs().getChosenPref();
  String editProfile = "Profil bearbeiten";
  late Future<String> usernameFuture;

  Future<void> signOut() async {
    await RAAuthService().signOut();
  }

  Widget signOutButton(Color color) {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text("sign out"),
      style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(color)),
    );
  }

  @override
  void initState() {
    super.initState();
    usernameFuture = loader.getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: signOutButton(RecipeAppColorStyles.navigationBarSelectedIconColor),
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
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
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
                                FutureBuilder(
                                  future: usernameFuture,
                                  builder:
                                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!, style: TextStyle(fontSize: 25),);
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    preference
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                            child: Icon(Icons.settings, size: 30,),
                          )
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettings())).then((value) => setMainPageState());
                            },
                            child: const SizedBox.shrink()),
                      ),
                    ),
                  ],
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
              child: SettingButton(text: 'Einstellungen', page: AppSettings(), setMainPageState: setMainPageState,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SettingButton(text: 'Nahrungsmittelpräferenzen', page: Preferences(), setMainPageState: setMainPageState,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SettingButton(text: 'Allergien', page: Allergies(), setMainPageState: setMainPageState,),
            ),
          ],
        ));
  }


  void setMainPageState(){
    setState(() {
      preference = SharedPrefs().getChosenPref();
      usernameFuture = loader.getUsername();
    });
  }
}
