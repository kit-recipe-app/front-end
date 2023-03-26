import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Login and register page that is shown when no user is authenticated
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String loginToRegister = "Du hast noch keinen Account?";
  final String registerToLogin = "Zurück zum Login.";
  String? errorMessage = ""; // The error message, empty if no error exists.
  bool isLogin = true; // Flag showing if user tries to login or to register.

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  /// Calls the signInWithGoogle method of the authService and updates the page to show error, if occuring
  Future<void> signInWithGoogle() async {
    try {
      await RAAuthService().signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  /// Calls the signInWithEmailAndPassword method of the authService and updates the page to show error, if occuring
  Future<void> signInWithEmailAndPassword() async {
    try {
      await RAAuthService().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  /// Calls the createUserWithEmailAndPassword method of the authService and updates the page to show error, if occuring
  Future<void> createUserWithEmailAndPassword() async {
    if (_controllerPassword.text != _controllerConfirmPassword.text) {
      setState(() {
        errorMessage = "Passwörter stimmen nicht überein.";
      });
      return;
    }
    try {
      await RAAuthService().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  /// Returns a TextWidget, which holds empty text or an errorMessage, if error is current
  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  /// Changes the state of the page to either login or register, depending on current state
  void switchLoginOrRegister() {
    setState(
      () {
        if (!isLogin) {
          _controllerConfirmPassword.text = "";
        }
        isLogin = !isLogin;
      },
    );
  }

  /// Returns what is shown in 'LoginPage'.
  /// PageTitle, InputFields, Login-/RegisterButton, StateSwitchButton
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          colors: RecipeAppColorStyles.loginRegisterBackground,
        ),
      ),
      child: SafeArea(
        left: false,
        bottom: false,
        right: false,
        child: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                isLogin ? "LOGIN" : "REGISTRIERUNG",
                key: const Key("Login"),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RAInputField(
                    key: const Key("EmailInput"),
                    hintText: "Email",
                    controller: _controllerEmail,
                    icon: Icons.mail,
                  ),
                  RAInputField(
                    key: const Key("PasswordInput"),
                    hintText: "Passwort",
                    controller: _controllerPassword,
                    isPassword: true,
                    icon: Icons.key,
                  ),
                  Visibility(
                    visible: !isLogin,
                    child: RAInputField(
                      hintText: "Passwort bestätigen",
                      controller: _controllerConfirmPassword,
                      isPassword: true,
                      icon: Icons.key,
                    ),
                  ),
                  _errorMessage(),
                  isLogin
                      ? RAButton(
                          key: const Key("LoginButton"),
                          onTap: signInWithEmailAndPassword,
                          description: "Login",
                          backgroundColor:
                              RecipeAppColorStyles.recipeAppMainColor,
                        )
                      : RAButton(
                          onTap: createUserWithEmailAndPassword,
                          description: "Registrieren",
                          backgroundColor:
                              RecipeAppColorStyles.recipeAppMainColor,
                        ),
                  /*
                  isLogin
                      ? RAButton(
                          onTap: signInWithGoogle,
                          description: "Mit Google anmelden",
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          margin: 16,
                          icon: FontAwesomeIcons.google,
                          iconColor: Colors.red,
                        )
                      : Container(),
                  */
                ],
              ),
            ),
            floatingActionButton: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
              child: RAButton(
                onTap: switchLoginOrRegister,
                description: isLogin ? loginToRegister : registerToLogin,
                margin: 16,
                shadow: false,
                backgroundColor: Colors.black54,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        ),
      ),
    );
  }
}
