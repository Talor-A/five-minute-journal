import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MyThemes { light, dark }

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF6B64A8),
  backgroundColor: Color(0xFF131513),
  accentColor: Colors.pinkAccent,
  canvasColor: Color(0xFF252529),
);

var lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.indigo,
  accentColor: Colors.pinkAccent,
  canvasColor: Color(0xFFF2F2F7),
);

class ThemeProvider with ChangeNotifier {
  //List all themes. Here we have two themes: light and dark
  static final List<ThemeData> themeData = [lightTheme, darkTheme];
  SharedPreferences prefs;
  MyThemes _currentTheme;
  ThemeData _currentThemeData;

  ThemeProvider(this.prefs) {
    String theme;
    if (prefs.containsKey("theme")) {
      theme = prefs.getString("theme");
      print("restoring theme $theme from saved data");
    } else {
      theme = "light";
    }
    this.currentTheme = theme == "light" ? MyThemes.light : MyThemes.dark;
  }

  void switchTheme() => currentTheme == MyThemes.light
      ? currentTheme = MyThemes.dark
      : currentTheme = MyThemes.light;

  set currentTheme(MyThemes theme) {
    if (theme != null) {
      _currentTheme = theme;
      _currentThemeData =
          currentTheme == MyThemes.light ? themeData[0] : themeData[1];
      notifyListeners();
      prefs
          .setString("theme", currentTheme == MyThemes.light ? "light" : "dark")
          .then((result) {
        print("set theme successfully: $result");
      });
    }
  }

  get currentTheme => _currentTheme;
  get currentThemeData => _currentThemeData;
}
