import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/recipe_app.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';

/// EmailVerificationPage that shows a verificationPage if user is authenticated but has not
/// verified email yet. Or the App itself if email is verified.
class EmailVerificationCheck extends StatefulWidget {
  const EmailVerificationCheck({super.key});

  @override
  State<EmailVerificationCheck> createState() => _EmailVerificationCheckState();
}

class _EmailVerificationCheckState extends State<EmailVerificationCheck> {
  User? user = RAAuthService().user; // The currently quthenticated user.
  bool emailIsVerified = false; // Flag showing if users email is verified.
  Timer? timer; // Timer that gets initialized in the initState-method and used to reload the user
  bool hasError = false; // Flag showing if an error occured.
  String errorMessage = ""; // The error message, empty if no error exists.
  bool canResendEmail = false; // Flag showing if last email has been sent more than 10 seconds ago.

  /// Initializes the WidgetState's attributes and checks every 5 seconds if something has changed.
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

  /// Disposes the timer and the widget itself.
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  /// Reloads the current user's data and updates the 'emailIsVerified' atteribute.
  Future checkEmailVerified() async {
    await user!.reload();
    user = RAAuthService().user;

    setState(() {
      emailIsVerified = user!.emailVerified;
    });

    if (emailIsVerified) timer?.cancel();
  }

  /// Sends a verification-email to the authenticated user and sets the
  /// 'canResendEmail' attribute to false for 10 seconds.
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

  /// Returns an button with which the user can return to the LoginPage.
  Widget cancelVerificationButton() {
    return ElevatedButton(
      onPressed: RAAuthService().signOut,
      child: const Text("Abbrechen"),
    );
  }

  /// Returns what is shown in 'EmailVerificationCheck'.
  /// Shows the App itself, if the user has verified email or a page to resend
  /// verification-email.
  /// RecipeApp
  /// OR
  /// VerificationPage (ResendEmailButton, QuitButton, InfoText)
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
                    ? RAButton(
                        onTap: sendVerificationEmail,
                        description: "Email Erneut senden",
                        backgroundColor:
                            RecipeAppColorStyles.recipeAppMainColor,
                        margin: 32,
                      )
                    : RAButton(
                        onTap: () {},
                        description: "Warte einen Moment",
                        margin: 32,
                      ),
                hasError ? Text(errorMessage) : Container(),
              ],
            ),
          ),
          floatingActionButton: RAButton(
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
