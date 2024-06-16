import 'package:flutter/material.dart';
import 'package:gloss_ll/src/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeManager extends ChangeNotifier {
  ThemeModeManager(this.sharedPreferences);
  SharedPreferences sharedPreferences;

  set mode(ThemeMode themeMode) {
    String darkModeSetting = DARK_MODE_SYSTEM;
    switch (themeMode) {
      case ThemeMode.system:
        darkModeSetting = DARK_MODE_SYSTEM;
        break;
      case ThemeMode.dark:
        darkModeSetting = DARK_MODE_ON;
        break;
      case ThemeMode.light:
        darkModeSetting = DARK_MODE_OFF;
        break;
    }

    sharedPreferences.setString(DARK_MODE_SETTING, darkModeSetting);
    notifyListeners();
  }

  ThemeMode get mode {
    String darkModeSetting =
        sharedPreferences.getString(DARK_MODE_SETTING) ?? DARK_MODE_SYSTEM;

    switch (darkModeSetting) {
      case DARK_MODE_SYSTEM:
        return ThemeMode.system;
      case DARK_MODE_ON:
        return ThemeMode.dark;
      case DARK_MODE_OFF:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  bool isDarkMode(BuildContext context) {
    if (mode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      return mode == ThemeMode.dark;
    }
  }
}
