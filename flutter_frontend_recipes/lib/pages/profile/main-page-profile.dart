import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';
import 'package:flutter_frontend_recipes/content_examples/initiating_examples.dart';
import 'package:flutter_frontend_recipes/pages/profile/change_allergies.dart';

import '../../constants/color_styles.dart';
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


  //TODO:hier später echtes Profil reinmachen
  Profile currentProfile = InitiatingExamples().exampleProfiles[0];

  String vegetarian = 'Vegetarier:  ';
  String allergies = 'Allergien:   ';
  String changeAllergies = 'Allergien ändern';

  //TODO: Das mit dem Profil speichern
  bool profileVegetarian = false;
  String listOfAllergies = '';
  String dummy = '';


  void changeAllergyText(String dummy) {
    setState(() {
      listOfAllergies = dummy;
    });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: signOutButton(),

      body: Column(
        children: [
          const SizedBox(height: 40,),
          Center(
            child: Container(
              width: 160,
              height: 50,
              color: Colors.green,
              child: Center(
                child: Text(
                  'Profil',
                  style: FontStyles.appBarText,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              width: 350,
              child: Text(
                'Name:   ${currentProfile.name}',
                style: FontStyles.bigText,
              ),
            ),
          ),
          Container(
            color: Colors.green,
            height: 3,
            width: 400,
          ),
          Flexible(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 10, 30),
                  child: SizedBox(
                    width: 350,
                    child: Text(
                      "Email:          ${user!.email!}",
                      style: FontStyles.bigText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.green,
            height: 3,
            width: 400,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 10, 30),
            child: Row(
              children: [
                Text(
                    vegetarian,
                  style: FontStyles.bigText,
                ),

                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Checkbox(
                          value: profileVegetarian,
                          activeColor: Colors.green,
                          onChanged: (newBool) {
                            setState(() {
                              profileVegetarian = newBool!;
                            });
                          });
                    }),
              ],
            ),
          ),

          Container(
            color: Colors.green,
            height: 3,
            width: 400,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 10, 10),
            child: SizedBox(
                width: 350,
              child: Text(
                '$allergies $listOfAllergies',
                style: FontStyles.bigText,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: RecipeAppColorStyles.addButtonColor,
            ),
            onPressed: ()  async {
              dummy = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeAllergies(
                      listOfAllergies: listOfAllergies,
                    )
                ),
              );

              changeAllergyText(dummy);
            },
            child: Text(
                changeAllergies,
              style: FontStyles.bigText,
            ),
          ),
        ],
      ),
    );
  }
}
