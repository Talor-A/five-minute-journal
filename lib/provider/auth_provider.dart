import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/boot/my_app.dart';
import 'package:june_lake/model/user.dart';
import 'package:provider/provider.dart';

class AuthProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // provide streams to the app to watch
    return StreamProvider<AuthState>.value(
      value: auth.status,
      child: MyApp(),
    );
  }
}
