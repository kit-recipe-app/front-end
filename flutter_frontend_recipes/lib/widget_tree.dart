import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/authentification/login_register_page.dart';
import 'package:flutter_frontend_recipes/authentification/verification_check.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RAAuthService().userStream,
      key: Key("StreamBuilder"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const EmailVerificationCheck(key: Key("EmailCheck"),);
        } else {
          return const LoginPage(key: Key("LoginPage"),);
        }
      },
    );
  }
}
