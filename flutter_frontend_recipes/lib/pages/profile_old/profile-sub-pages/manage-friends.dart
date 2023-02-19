import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile_old/profile-page-components/profil-page-appbar.dart';


class ManageFriends extends StatefulWidget {
  const ManageFriends({Key? key}) : super(key: key);

  @override
  State<ManageFriends> createState() => _ManageFriendsState();
}

class _ManageFriendsState extends State<ManageFriends> {
  
  String title = 'Frende verwalten';
  BuildProfiLAppBar bar = BuildProfiLAppBar();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar.profilAppBar(title),
    );
  }
}


