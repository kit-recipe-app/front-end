import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/profile-sub-pages/manage-friends.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/profile-sub-pages/setting-option-card.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/profile-sub-pages/profile-settings.dart';

import 'change-preferences.dart';


class ProfilPageOptions {
  

  List<Widget> listOfOptions = [
    ProfilPageSettingOptionCard(title: 'Einstellung',
        page: ProfileSettingsPage()),
    ProfilPageSettingOptionCard(title: 'Präferenzen ändern',
        page: ChangePreferences()),
    ProfilPageSettingOptionCard(title: 'Freunde verwalten',
      page: ManageFriends())
  ];


}



