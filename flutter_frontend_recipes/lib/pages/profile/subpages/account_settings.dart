import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../authentification/auth.dart';
import 'account_tile.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

  final User? user = RAAuthService().user;
  late String? email = user?.email;
  String name = "Johannes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        leading: const BackButton(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text("Kontoeinstellungen", style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          AccountTile(text: "E-Mail-Adresse", info: email!),
          Divider(thickness: 0.9, color: Colors.grey, height: 0,),
          AccountTile(text: "Nutzername", info: name),
          Divider(thickness: 0.9, color: Colors.grey, height: 0,),
          AccountTile(text: "Passwort", info: "**********"),
          SizedBox(
            height: 100,
          ),
          AccountTile(text: "Account löschen", info: ""),
        ],
      ),
    );
  }
}
