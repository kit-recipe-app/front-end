import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_frontend_recipes/widget_tree.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff66aa44),
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Color(0xffb00020),
          onError: Colors.white,
          background:  Colors.white.withOpacity(0.9),
          onBackground: Colors.black,
          surface:  Colors.white,
          onSurface: Colors.black,
          secondaryContainer: Colors.white.withOpacity(0.9)),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          )),
      darkTheme: ThemeData(
          //scaffoldBackgroundColor: Colors.grey.shade800,
          colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: Color(0xff66aa44),
              onPrimary: Colors.black,
              secondary: Colors.black,
              onSecondary: Colors.white,
              error: Color(0xffcf6679),
              onError: Colors.black,
              background: Colors.grey.shade700,
              onBackground: Colors.white,
              surface: Color(0xff121212),
              onSurface: Colors.white,
              secondaryContainer: Colors.grey.shade700),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff121212),
          )),
      themeMode: _themeMode,
      home: WidgetTree(),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
