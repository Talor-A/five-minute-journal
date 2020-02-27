import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/app_info.dart';
import 'package:june_lake/details.dart';
import 'package:june_lake/entries.dart';
import 'package:june_lake/model/entry.dart';
import 'package:june_lake/model/user.dart';
import 'package:june_lake/provider/entry_provider.dart';
import 'package:june_lake/style/theme.dart' as MyTheme;
import 'package:provider/provider.dart';

import '../calendar.dart';
import '../login.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.calendar_today)),
              Tab(icon: Icon(Icons.info)),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            FirstRoute(),
            SecondRoute(),
            AppInfo(),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  Widget _getFirstRoute(BuildContext context) {
    var state = Provider.of<AuthState>(context);

    if (state is LoggedIn) return EntryProvider(child: TabNavigator());

    if (state is LoggedOut) return LoginPage();

    return Container(color: MyTheme.Colors.loginGradientEnd);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transition Demo',
      home: _getFirstRoute(context),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'American Typewriter',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(),
      ),
    );
  }
}
