import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile-page-components/profil-page-appbar.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {

  BuildProfiLAppBar buildProfiLAppBar =  BuildProfiLAppBar();

  String profilSettings = 'Profil Einstellungen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildProfiLAppBar.profilAppBar(profilSettings),
    );
  }
}


