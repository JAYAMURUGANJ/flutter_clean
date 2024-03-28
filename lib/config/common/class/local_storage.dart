import 'package:shared_preferences/shared_preferences.dart';

//key
const String spNetworkIp = '192.168.224.50';
const String spLocalLanguage = 'EN';
const String spAppVersion = "1.0.0";

class Prefs {
  static late SharedPreferences _prefs;

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

  //gets
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
