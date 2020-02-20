import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_1/app_info.dart';
import 'package:flutter_day_1/entries.dart';
import 'package:provider/provider.dart';

import '../calendar.dart';
import '../login.dart';

class MyApp extends StatelessWidget {
  Widget _getFirstRoute(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    if (user == null) return LoginPage();

    return FirstRoute();
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
