import 'package:flutter/material.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/pages/fancy_drawer.dart';
import 'package:june_lake/pages/login.dart';
import 'package:june_lake/provider/log_provider.dart';
import 'package:june_lake/provider/theme_provider.dart';
import 'package:june_lake/provider/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  Widget _getFirstRoute(BuildContext context) {
    var state = Provider.of<AuthState>(context);

    if (state is LoggedIn) return LogProvider(child: FancyDrawer());

    if (state is LoggedOut) return LoginPage();

    return Container(color: Theme.of(context).primaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: MaterialApp(
        title: 'Transition Demo',
        home: _getFirstRoute(context),
        theme: Provider.of<ThemeProvider>(context).currentThemeData,
      ),
    );
  }
}
