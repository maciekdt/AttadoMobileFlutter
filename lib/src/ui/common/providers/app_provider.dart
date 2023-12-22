import 'package:attado_mobile/src/services/app_preferences_service.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool showBottomNavigation = true;
  /*bool get showBottomNavigation => _showBottomNavigation;
  set showBottomNavigation(bool value) {
    _showBottomNavigation = value;
    notifyListeners();
  }*/

  bool documentsListFirstRun = true;
  bool foldersListFirstRun = true;
  bool contactsListFirstRun = true;
  bool tasksListFirstRun = true;

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  setDarkTheme(bool value) async {
    _darkTheme = value;
    notifyListeners();
    await AppPreferencesService.setDarkTheme(value);
  }

  setThemeFromStorage() async {
    _darkTheme = await AppPreferencesService.isDarkTheme();
    notifyListeners();
  }
}
