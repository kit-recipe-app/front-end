import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_frontend_recipes/backend_connection/ingredient_loader.dart';
import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_frontend_recipes/widget_tree.dart';
import 'package:http/http.dart' as http;
import 'constants/color_styles.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Main Function of the app. This is called when the app is started.
Future<void> main() async {

  /// Initializes the binding for the Flutter app's widgets.
  WidgetsFlutterBinding.ensureInitialized();

  /// Then, Firebase.initializeApp() is called to initialize the
  /// Firebase app using the default options for the current platform. 
  /// This is a necessary step for using Firebase services in the app.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Called to initialize the app's shared preferences.
  await SharedPrefs().init();

  /// Initializes the IngredientLoader class, which is responsible
  /// for loading ingredient data from an external API. It requires
  /// an HTTP client and an instance of FirebaseAuth for user authentication.
  await IngredientLoader().init(http.Client(), FirebaseAuth.instance);

  /// The actual App gets started and rendered on the users device.
  runApp(const MyApp());
}

/// The MyApp widget is the root of the app and it uses a MaterialApp widget
/// as the main container. It defines the light and dark themes, and sets the
/// theme mode based on the value stored in Shared Preferences. It also sets
/// the WidgetTree as the initial screen.
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

  /// Switches the current theme of the app
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
