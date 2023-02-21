import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  bool? getTheme(){
    return _sharedPrefs.getBool("selectedTheme");
  }

  void setTheme(bool value) {
    _sharedPrefs.setBool("selectedTheme", value);  // Using selectedThemeIndex from constant
  }
}