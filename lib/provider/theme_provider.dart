import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MyThemes { light, dark }

var primaryPurple = Color(0xFF6B64A8);
var purple = MaterialColor(0xFF6B64A8, {
  50: Color(0xFFedecf5),
  100: Color(0xFFd3d1e5),
  200: Color(0xFFb5b2d4),
  300: Color(0xFF9793c2),
  400: Color(0xFF817bb5),
  500: Color(0xFF6b64a8),
  600: Color(0xFF635ca0),
  700: Color(0xFF585297),
  800: Color(0xFF4e488d),
  900: Color(0xFF3c367d),
});

var darkBG = Color(0xFF252529);
var dark = MaterialColor(0xFF252529, {
  50: Color(0xFFe5e5e5),
  100: Color(0xFFbebebf),
  200: Color(0xFF929294),
  300: Color(0xFF666669),
  400: Color(0xFF464649),
  500: Color(0xFF252529),
  600: Color(0xFF212124),
  700: Color(0xFF1b1b1f),
  800: Color(0xFF161619),
  900: Color(0xFF0d0d0f),
});

var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF6B64A8),
    backgroundColor: Color(0xFF131513),
    accentColor: Colors.pinkAccent,
    canvasColor: Color(0xFF252529),
    chipTheme: ThemeData.dark().chipTheme.copyWith(
        backgroundColor: Color(0xFF464649),
        secondarySelectedColor: Color(0xFF6B64A8),
        selectedColor: Colors.pinkAccent,
        secondaryLabelStyle:
            ThemeData.dark().chipTheme.secondaryLabelStyle.copyWith(
                  color: Colors.white,
                )));

var lightTheme = ThemeData(
    brightness: Brightness.light,
    // primaryColor: Colors.indigo,
    primaryColor: Color(0xFF6B64A8),
    accentColor: Colors.pinkAccent,
    canvasColor: Color(0xFFF2F2F7),
    // backgroundColor: Colors.indigo,
    backgroundColor: Color(0xFF6B64A8),
    chipTheme: ThemeData.light().chipTheme.copyWith(
        secondarySelectedColor: Color(0xFF6B64A8),
        selectedColor: Colors.pinkAccent,
        secondaryLabelStyle:
            ThemeData.light().chipTheme.secondaryLabelStyle.copyWith(
                  color: Colors.white,
                )));

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
      prefs.setString(
          "theme", currentTheme == MyThemes.light ? "light" : "dark");
    }
  }

  get currentTheme => _currentTheme;
  get currentThemeData => _currentThemeData;
}
