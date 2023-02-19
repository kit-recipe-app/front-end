import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_tile.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/widget_tile.dart';

import '../../../authentification/auth.dart';
import '../../../main.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  final User? user = RAAuthService().user;
  late String? email = user?.email;
  String name = "Johannes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Kontoeinstellungen",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          TextTile(text: "Sprache", info: "Deutsch"),
          const TileDivider(),
          TextTile(text: "Land", info: "Deutschland"),
          const TileDivider(),
          WidgetTile(
              text: "Design",
              info: Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (bool value) {
                    value == true
                        ? MyApp.of(context).changeTheme(ThemeMode.dark)
                        : MyApp.of(context).changeTheme(ThemeMode.light);
                  }))
        ],
      ),
    );
  }
}
