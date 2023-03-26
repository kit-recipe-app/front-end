import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_frontend_recipes/backend_connection/ingredient_loader.dart';
import 'package:flutter_frontend_recipes/backend_connection/unit_loader.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/widget_tree.dart';
import 'package:http/http.dart' as http;
import 'constants/color_styles.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs().init();
  await IngredientLoader().init(http.Client(), FirebaseAuth.instance);
  await UnitLoader().init(http.Client(), FirebaseAuth.instance);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = SharedPrefs().getTheme() == null
      ? ThemeMode.system
      : (SharedPrefs().getTheme() == true ? ThemeMode.dark : ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Recipe App',
      theme: RecipeAppColorStyles.lightTheme,
      darkTheme: RecipeAppColorStyles.darkTheme,
      themeMode: _themeMode,
      home: const WidgetTree(),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
