import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:june_lake/model/user.dart';
import 'package:provider/provider.dart';

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    var text = (user == null) ? 'no user' : 'hi ${user.name}!';

    return Scaffold(
      appBar: AppBar(
        title: Text('App Info'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Text(text),
          MaterialButton(
            onPressed: FirebaseAuth.instance.signOut,
            child: Text('Log Out'),
          ),
        ],
      )),
    );
  }
}
