import 'package:flutter/material.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/pages/app_info.dart';
import 'package:june_lake/pages/calendar.dart';
import 'package:june_lake/pages/entries.dart';
import 'package:june_lake/pages/journal.dart';
import 'package:june_lake/pages/login.dart';
import 'package:june_lake/pages/swiper.dart';
import 'package:june_lake/provider/entry_provider.dart';
import 'package:june_lake/provider/log_provider.dart';
import 'package:june_lake/style/theme.dart' as MyTheme;
import 'package:provider/provider.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: SafeArea(
            // backgroundColor: Theme.of(context).canvasColor,
            // elevation: 0.0,
            child: TabBar(
              indicatorColor: Colors.transparent,
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              tabs: [
                Tab(
                  text: 'Journal',
                ),
                // Tab(icon: Icon(Icons.calendar_today)),
                Tab(icon: Icon(Icons.info)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Journal(),
            // SecondRoute(),
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

    if (state is LoggedIn)
      return LogProvider(child: EntryProvider(child: TabNavigator()));

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
        primaryColor: Colors.indigo,
        accentColor: Colors.pinkAccent,

        // Define the default font family.
        // fontFamily: 'American Typewriter',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(),
      ),
    );
  }
}
