import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/model/user.dart';
import 'package:june_lake/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthState>(context).user;

    var text = (user == null) ? 'no user' : 'hi ${user.name}!';

    return Flex(direction: Axis.horizontal, children: [
      Expanded(
        child: Container(
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(text),
                onTap: () {},
              ),
              FlatButton(
                onPressed: FirebaseAuth.instance.signOut,
                child: Text('Log Out'),
              ),
              FlatButton(
                // color: Theme.of(context).accentColor,
                // textColor: Theme.of(context).accentTextTheme.button.color,
                onPressed: () =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .switchTheme(),
                child: Text('Switch Theme'),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
