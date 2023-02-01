import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/recipe_app.dart';
import 'package:flutter_frontend_recipes/shared/submit_button.dart';

class EmailVerificationCheck extends StatefulWidget {
  const EmailVerificationCheck({super.key});

  @override
  State<EmailVerificationCheck> createState() => _EmailVerificationCheckState();
}

class _EmailVerificationCheckState extends State<EmailVerificationCheck> {
  User? user = RAAuthService().user;
  bool emailIsVerified = false;
  Timer? timer;
  bool hasError = false;
  String errorMessage = "";
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    emailIsVerified = user!.emailVerified;
    if (!emailIsVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 5),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await user!.reload();
    user = RAAuthService().user;

    setState(() {
      emailIsVerified = user!.emailVerified;
    });

    if (emailIsVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      await user!.sendEmailVerification();

      setState(
        () => canResendEmail = false,
      );
      await Future.delayed(const Duration(seconds: 10));
      setState(
        () => canResendEmail = true,
      );
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = e.toString();
      });
    }
  }

  Widget cancelVerificationButton() {
    return ElevatedButton(
      onPressed: RAAuthService().signOut,
      child: const Text("Abbrechen"),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (emailIsVerified) {
      return const RecipeApp();
    }
    return Container(
      color: RecipeAppColorStyles.backGroundColor,
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Ihnen wurde eine Email zur Verifikation gesendet."),
                canResendEmail
                    ? RASubmitButton(
                        onTap: sendVerificationEmail,
                        description: "Email Erneut senden",
                        backgroundColor:
                            RecipeAppColorStyles.recipeAppMainColor,
                        margin: 32,
                      )
                    : RASubmitButton(
                        onTap: () {},
                        description: "Warte einen Moment",
                        margin: 32,
                      ),
                hasError ? Text(errorMessage) : Container(),
              ],
            ),
          ),
          floatingActionButton: RASubmitButton(
            onTap: RAAuthService().signOut,
            description: "Abbrechen",
            margin: 8,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
