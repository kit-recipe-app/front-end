import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_tile.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/widget_tile.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.onSecondary),
        title: Text(
          "Appeinstellungen",
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: Column(
        children: [
          TextTile(text: "Sprache", info: "Deutsch", type: "language",),
          const TileDivider(),
          TextTile(text: "Land", info: "Deutschland", type: "country"),
          const TileDivider(),
          WidgetTile(
              text: "Design",
              info: Switch(
                activeColor: Theme.of(context).colorScheme.primary,
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (bool value) {
                  SharedPrefs().setTheme(value);
                    value == true
                        ? MyApp.of(context).changeTheme(ThemeMode.dark)
                        : MyApp.of(context).changeTheme(ThemeMode.light);
                  }))
        ],
      ),
    );
  }

}
