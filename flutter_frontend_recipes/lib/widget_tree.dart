import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/authentification/login_register_page.dart';
import 'package:flutter_frontend_recipes/authentification/verification_check.dart';

/// The WidgetTree class is a stateful widget that displays different
/// screens based on the user's authentication status.
class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

/// The StreamBuilder widget takes in a stream of user data from RAAuthService()
/// and renders a child widget based on the current snapshot of the stream.
/// If the snapshot has data, the EmailVerificationCheck widget is displayed,
/// which checks if the user has verified their email. If the snapshot doesn't
/// have data, the LoginPage widget is displayed, which prompts the user to log in.
class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RAAuthService().userStream,
      key: const Key("StreamBuilder"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const EmailVerificationCheck(
            key: Key("EmailCheck"),
          );
        } else {
          return const LoginPage(
            key: Key("LoginPage"),
          );
        }
      },
    );
  }
}
