import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_day_1/app_info.dart';
import 'package:flutter_day_1/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'entries.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'enzo',
    options: const FirebaseOptions(
      googleAppID: '1:136511537243:ios:1a30cc973b60e3aeceff7e',
      // gcmSenderID: '79601577497',
      apiKey: 'AIzaSyDNilFa3qX9WZGZ1W2UYOjiB1GduguZ9Mc',
      projectID: 'cs-4990-mobile-dev-project',
    ),
  );
  final Firestore firestore = Firestore(app: app);

  runApp(AppProvider(
    firestore: firestore,
  ));
}

class AppProvider extends StatelessWidget {
  final Firestore firestore;
  AppProvider({this.firestore});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Make user stream available
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),

        // See implementation details in next sections
        StreamProvider<QuerySnapshot>.value(
          value: firestore
              .collection("messages")
              .orderBy("created_at", descending: true)
              .snapshots(),
        ),
      ],

      // All data will be available in this child and descendents
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  Widget _getFirstRoute(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    if (user == null) return LoginPage();
    return AppInfo();
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
