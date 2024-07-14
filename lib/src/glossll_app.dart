import 'package:gloss_ll/src/app_data.dart';
import 'package:gloss_ll/src/modules/configure_playback_page/configre_playback_page.dart';
import 'package:gloss_ll/src/modules/home/home_page.dart';
import 'package:gloss_ll/src/modules/playback_page/playback_page.dart';
import 'package:gloss_ll/src/modules/select_subtitles/select_subtitles_page.dart';
import 'package:gloss_ll/src/modules/settings/settings_page.dart';
import 'package:gloss_ll/src/util/theme_mode_manager.dart';
import 'package:gloss_ll/src/util/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlossLlApp extends StatefulWidget {
  const GlossLlApp({super.key});

  @override
  State<GlossLlApp> createState() => _GlossLlAppState();
}

class _GlossLlAppState extends State<GlossLlApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initApp(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider.value(
            value: AppData.themeModeManager,
            child: Consumer<ThemeModeManager>(
              builder: (context, themeModeManager, _) {
                return MaterialApp(
                  title: 'GlossLL',
                  themeMode: themeModeManager.mode,
                  theme: buildThemeData(context),
                  darkTheme: buildDarkThemeData(context),
                  initialRoute: '/home',
                  navigatorObservers: [AppData.routeObserver],
                  onGenerateRoute: (RouteSettings settings) {
                    var routes = <String, WidgetBuilder>{
                      "/": (context) => Container(),
                      "/home": (context) => const HomePage(),
                      "/select-subtitles": (context) =>
                          const SelectSubtitlesPage(),
                      "/configure-subtitles": (context) =>
                          ConfigurePlaybackPage(
                            args: settings.arguments
                                as ConfigurePlaybackPageArguments,
                          ),
                      "/playback": (context) => PlaybackPage(
                            args: settings.arguments as PlaybackPageArguments,
                          ),
                      "/settings": (context) => SettingsPage(),
                    };
                    return CupertinoPageRoute(
                      builder: (context) => routes[settings.name]!(context),
                    );
                  },
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<void> _initApp() async {
    AppData(await SharedPreferences.getInstance()); // Singleton initialized

    return Future.value();
  }
}
