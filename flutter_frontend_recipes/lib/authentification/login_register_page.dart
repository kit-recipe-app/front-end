import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_frontend_recipes/authentification/auth.dart';
import 'package:flutter_frontend_recipes/constants/color_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String loginToRegister = "Du hast noch keinen Account?";
  final String registerToLogin = "Du hast bereits einen Account?";
  String? errorMessage = "";
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

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

  Widget _entryField(
    String title,
    TextEditingController controller,
    bool isPassword,
  ) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: title,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          color: RecipeAppColorStyles.authButtonColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Text(
          isLogin ? 'Login' : 'Registrieren',
          style: TextStyle(
            fontSize: 16,
            color: RecipeAppColorStyles.authButtonTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    /*
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Registrieren'),
    );
    */
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? loginToRegister : registerToLogin),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RecipeAppColorStyles.backGroundColor,
      child: SafeArea(
        left: false,
        bottom: false,
        right: false,
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _entryField(
                  'email',
                  _controllerEmail,
                  false,
                ),
                _entryField(
                  'password',
                  _controllerPassword,
                  true,
                ),
                _errorMessage(),
                _submitButton(),
                _loginOrRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
