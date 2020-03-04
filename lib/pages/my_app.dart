import 'package:flutter/material.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/pages/login.dart';
import 'package:june_lake/pages/tabs.dart';
import 'package:june_lake/provider/entry_provider.dart';
import 'package:june_lake/provider/log_provider.dart';
import 'package:provider/provider.dart';

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF6B64A8),
  accentColor: Colors.pinkAccent,
  canvasColor: Color(0xFF252529),
);

var lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.indigo,
  accentColor: Colors.pinkAccent,
  canvasColor: Color(0xFFF2F2F7),
);

class MyApp extends StatelessWidget {
  Widget _getFirstRoute(BuildContext context) {
    var state = Provider.of<AuthState>(context);

    if (state is LoggedIn)
      return LogProvider(child: EntryProvider(child: TabNavigator()));

    if (state is LoggedOut) return LoginPage();

    return Container(color: Theme.of(context).primaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transition Demo',
      home: _getFirstRoute(context),
      theme: false ? darkTheme : lightTheme,
    );
  }
}
