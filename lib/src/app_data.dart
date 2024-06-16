import 'package:glossll/src/util/theme_mode_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppData {
  static late SharedPreferences sharedPreferences;
  static late ThemeModeManager themeModeManager;

  static final AppData _appData = new AppData._internal();

  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  factory AppData(SharedPreferences sharedPreferences) {
    AppData.sharedPreferences = sharedPreferences;
    AppData.themeModeManager = ThemeModeManager(sharedPreferences);

    return _appData;
  }

  AppData._internal();
}
