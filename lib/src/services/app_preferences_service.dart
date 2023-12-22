import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesService {
  static const themeStatus = "THEMESTATUS";
  static const _logName = "AppPreferencesService";

  static Future<void> setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }

  static Future<bool> isDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(themeStatus);
    log(
      "Dark theme option restored from SharedPreferences value=$value",
      name: _logName,
    );
    return value ?? false;
  }
}
