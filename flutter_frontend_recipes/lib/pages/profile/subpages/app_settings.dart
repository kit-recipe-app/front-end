import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/text_tile.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/widget_tile.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';

import '../../../main.dart';

/// A widget that displays the application settings.
class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: BackButton(
            key: const Key("BackButton"),
            color: Theme.of(context).colorScheme.onSecondary),
        title: Text(
          "Appeinstellungen",
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: Column(
        children: [
          /// A tile widget that displays the language information.
          TextTile(
            text: "Sprache",
            info: "Deutsch",
            type: "language",
          ),
          const TileDivider(),
          /// A tile widget that displays the country information.
          TextTile(text: "Land", info: "Deutschland", type: "country"),
          const TileDivider(),
          /// A widget tile that displays the design information and has a switch to toggle the theme.
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
                  })),
          const SizedBox(
            height: 100,
          ),
          /// Tile to delete Data
          TextTile(
            text: "Daten löschen",
            info: "",
            type: 'data',
          ),
        ],
      ),
    );
  }
}
