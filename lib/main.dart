import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiveminutejournal/provider/auth_provider.dart';
import 'package:fiveminutejournal/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'june_lake',
    options: const FirebaseOptions(
      googleAppID: '1:136511537243:ios:1a30cc973b60e3aeceff7e',
      // gcmSenderID: '79601577497',
      apiKey: 'AIzaSyDNilFa3qX9WZGZ1W2UYOjiB1GduguZ9Mc',
      projectID: 'cs-4990-mobile-dev-project',
    ),
  );
  Firestore(app: app);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(ChangeNotifierProvider<ThemeProvider>(
    child: AuthProvider(),
    create: (BuildContext context) {
      return ThemeProvider(prefs);
    },
  ));
}
