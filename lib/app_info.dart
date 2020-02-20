import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_1/message_list.dart';
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

    assert(user != null);

    return Scaffold(
      appBar: AppBar(
        title: Text('App Info'),
      ),
      body: MessageList(),
    );
  }
}
