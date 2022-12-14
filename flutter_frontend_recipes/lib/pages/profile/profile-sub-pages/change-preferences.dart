import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/profil-page-appbar.dart';



class ChangePreferences extends StatefulWidget {
  const ChangePreferences({Key? key}) : super(key: key);

  @override
  State<ChangePreferences> createState() => _ChangePreferencesState();
}

class _ChangePreferencesState extends State<ChangePreferences> {

  BuildProfiLAppBar bar = BuildProfiLAppBar();

  String title = 'Präferenzen ändern';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar.profilAppBar(title),
    );
  }
}

