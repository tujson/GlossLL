import 'package:flutter/material.dart';
import 'package:glossll/src/app_data.dart';
import 'package:glossll/src/util/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          _buildDarkModeSetting(),
          const SizedBox(height: 64),
          _buildAboutSetting(),
        ],
      ),
    );
  }

  Widget _buildDarkModeSetting() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          _showDarkModeDialog();
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              (() {
                String darkModeState = 'System';
                switch (
                    AppData.sharedPreferences.getString(DARK_MODE_SETTING)) {
                  case DARK_MODE_ON:
                    darkModeState = 'On';
                    break;
                  case DARK_MODE_OFF:
                    darkModeState = 'Off';
                    break;
                  default:
                    darkModeState = 'System';
                }
                return Text(
                  darkModeState,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                );
              }()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSetting() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () async {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          showAboutDialog(
            context: context,
            applicationLegalese: 'https://synople.dev',
            applicationVersion:
                '${packageInfo.packageName}\n${packageInfo.version}+${packageInfo.buildNumber}',
          );
        },
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'About',
            style: TextStyle(
              fontSize: 21,
            ),
          ),
        ),
      ),
    );
  }

  void _showDarkModeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dark mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RadioListTile<String>(
              title: const Text('System'),
              value: ThemeMode.system.toString(),
              groupValue: AppData.themeModeManager.mode.toString(),
              onChanged: (value) {
                _setDarkMode(value!);
              },
            ),
            RadioListTile<String>(
              title: const Text('On'),
              value: ThemeMode.dark.toString(),
              groupValue: AppData.themeModeManager.mode.toString(),
              onChanged: (value) {
                _setDarkMode(value!);
              },
            ),
            RadioListTile<String>(
              title: const Text('Off'),
              value: ThemeMode.light.toString(),
              groupValue: AppData.themeModeManager.mode.toString(),
              onChanged: (value) {
                _setDarkMode(value!);
              },
            )
          ],
        ),
      ),
    );
  }

  void _setDarkMode(String darkModeSetting) async {
    ThemeMode selectedThemeMode = ThemeMode.system;
    if (darkModeSetting == ThemeMode.dark.toString()) {
      selectedThemeMode = ThemeMode.dark;
    } else if (darkModeSetting == ThemeMode.light.toString()) {
      selectedThemeMode = ThemeMode.light;
    }

    AppData.themeModeManager.mode = selectedThemeMode;

    Navigator.of(context, rootNavigator: true).pop();
  }
}
