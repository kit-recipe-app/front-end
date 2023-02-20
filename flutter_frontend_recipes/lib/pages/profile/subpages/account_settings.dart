import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';

import '../../../authentification/auth.dart';
import '../components/text_tile.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: BackButton(
            color: Theme.of(context).colorScheme.onSecondary
        ),
        title: Text("Kontoeinstellungen", style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
      ),
      body: Column(
        children: [
          TextTile(text: "E-Mail-Adresse", info: email!, type: "email"),
          TileDivider(),
          TextTile(text: "Nutzername", info: name, type: 'text',),
          TileDivider(),
          TextTile(text: "Passwort", info: "**********", type: 'text',),
          SizedBox(
            height: 100,
          ),
          TextTile(text: "Account löschen", info: "", type: 'text',),
        ],
      ),
    );
  }
}
