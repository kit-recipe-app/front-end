import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String loginToRegister = "Du hast noch keinen Account?";
  final String registerToLogin = "Zurück zum Login.";
  String? errorMessage = "";
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  Future<void> signInWithGoogle() async {
    try {
      await RAAuthService().signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

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

  Widget _pageTitle() {
    return Container(
      padding: EdgeInsets.only(
          bottom: isLogin
              ? MediaQuery.of(context).size.height / 8 + 66
              : MediaQuery.of(context).size.height / 8),
      child: Text(
        isLogin ? "LOGIN" : "REGISTRIERUNG",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

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
                key: Key("Login"),
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
                    key: Key("EmailInput"),
                    hintText: "Email",
                    controller: _controllerEmail,
                    icon: Icons.mail,
                  ),
                  RAInputField(
                    key: Key("PasswordInput"),
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
                    key: Key("LoginButton"),
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
