import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_1/data/entry.dart';
import 'package:flutter_day_1/data/message.dart';
import 'package:flutter_day_1/data/user.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

// for some reason this likes to be in its own class. needs separate context.
class InfoProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authUser = Provider.of<FirebaseUser>(context);
    return StreamProvider<User>.value(
      value: User.get(authUser),
      child: MyApp(),
    );
  }
}

class AppProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // provide streams to the app to watch
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
        StreamProvider<List<Message>>(
          create: (_) => streamMessages(),
          initialData: [],
        ),
      ],
      child: InfoProvider(), // all data will be available to MyApp()
    );
  }

  Stream<List<Message>> streamMessages() {
    var ref = Firestore.instance.collection(Message.collection);
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => Message.fromSnapshot(doc)).toList());
  }

  Stream<User> myFunc(FirebaseUser authUser) {
    return User.get(authUser);
  }
}
