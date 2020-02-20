import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppInfo extends StatelessWidget {
  login() {
    try {
      FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    QuerySnapshot messages = Provider.of<QuerySnapshot>(context);

    var loggedIn = user != null;

    // if (!loggedIn) login();

    return Scaffold(
      appBar: AppBar(
        title: Text('App Info'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('hello, ${user.displayName}!'),
            Text('messages: ${messages.documents.length}'),
            FlatButton(
              child: Text('logout'),
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
      ),
    );
  }
}
