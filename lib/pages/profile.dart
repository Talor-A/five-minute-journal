import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/model/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthState>(context).user;

    var text = (user == null) ? 'no user' : 'hi ${user.name}!';

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text(text),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Theme.of(context).accentTextTheme.button.color,
              onPressed: FirebaseAuth.instance.signOut,
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
