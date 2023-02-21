import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/profile/components/tile_divider.dart';

import '../../../authentification/auth.dart';
import '../../../backend_connection/loader.dart';
import '../../../backend_connection/putter.dart';
import '../components/password_tile.dart';
import '../components/text_tile.dart';
import '../components/username_tile.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final User? user = RAAuthService().user;
  late String? email = user?.email;
  String name = "Johannes";
  Loader loader = Loader();
  Putter putter = Putter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.onSecondary),
        title: Text(
          "Kontoeinstellungen",
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: Column(
        children: [
          TextTile(text: "E-Mail-Adresse", info: email!, type: "email"),
          TileDivider(),
          UsernameTile(
              title: "Nutzername",
              info: FutureBuilder(
                future: loader.getUsername(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
              ), setName: setUsername,
          ),
          TileDivider(),
          PasswordTile(
            title: "Passwort",
            setPassword: changePassword,
          ),
          SizedBox(
            height: 100,
          ),
          TextTile(
            text: "Account löschen",
            info: "",
            type: 'text',
          ),
        ],
      ),
    );
  }

  void setUsername(String result){
    setState(() {
      putter.putUsername(result);
    });
  }

  //maybe async
  String changePassword(String currentPassword, String newPassword) {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        return "erfolgreich";
      }).catchError((error) {
        return "neues Passwort ungültig";
      });
    }).catchError((err) {
    });
    return "altes Passwort ungültig";
  }

}
