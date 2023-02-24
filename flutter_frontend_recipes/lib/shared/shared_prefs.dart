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

  bool? getFoodPref(String pref){
    return _sharedPrefs.getBool(pref);
  }

  String getChosenPref(){
    List<String> prefs = ["Omnivor", "Vegan", "Vegetarisch", "Pescetarisch"];
    for (String pref in prefs){
     if (_sharedPrefs.getBool(pref) ?? false == true){
       return pref;
     }
    }
    return "Omnivor";
  }

  bool? getAllergy(String allergy){
    return _sharedPrefs.getBool(allergy);
  }

  void setTheme(bool value) {
    _sharedPrefs.setBool("selectedTheme", value);  // Using selectedThemeIndex from constant
  }

  void setFoodPref(String pref, bool value){
    _sharedPrefs.setBool(pref, value);
  }

  void setAllergy(String allergy, bool value){
    _sharedPrefs.setBool(allergy, value);
  }

  void setMultiplePref(List<String> prefs, bool value){
    for(String pref in prefs){
      _sharedPrefs.setBool(pref, value);
    }
  }

  void clear(){
    _sharedPrefs.clear();
  }
}