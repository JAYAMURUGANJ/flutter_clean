import 'package:shared_preferences/shared_preferences.dart';

//key
String spNetworkIp = '192.168.224.50';
String spLocalLanguage = 'EN';
String spAppVersion = "1.0.0";
String spOnBoardingStatus = "on_boarding_status";

class Prefs {
  static SharedPreferences _prefs =
      SharedPreferences.getInstance() as SharedPreferences;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  //sets
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  //gets
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
