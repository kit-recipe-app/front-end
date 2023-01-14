import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';
import 'package:flutter_frontend_recipes/shared/input_field.dart';
import 'package:flutter_frontend_recipes/shared/submit_button.dart';

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

  final TextEditingController _controllerTest = TextEditingController();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

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
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
      alignment: Alignment.topCenter,
      child: Text(
        isLogin ? "LOGIN" : "REGISTRIEREN",
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
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                _pageTitle(),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //
                      RAInputField(
                        hintText: "Email",
                        controller: _controllerEmail,
                        icon: Icons.mail,
                      ),
                      RAInputField(
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
                          ? RASubmitButton(
                              onTap: signInWithEmailAndPassword,
                              description: "Login",
                              backgroundColor:
                                  RecipeAppColorStyles.recipeAppMainColor,
                            )
                          : RASubmitButton(
                              onTap: createUserWithEmailAndPassword,
                              description: "Registrieren",
                              backgroundColor:
                                  RecipeAppColorStyles.recipeAppMainColor,
                            ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: RASubmitButton(
              onTap: switchLoginOrRegister,
              description: isLogin ? loginToRegister : registerToLogin,
              margin: 16,
              shadow: false,
              backgroundColor: Colors.black54,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        ),
      ),
    );
  }
}
