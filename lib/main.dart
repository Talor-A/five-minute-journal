import 'package:flutter/material.dart';
import 'package:flutter_day_1/widget/test.dart';
import 'data/Entry.dart';
import 'details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transition Demo',
      home: FirstRoute(),
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

class FirstRouteState extends State<FirstRoute> {
  var entries = List<Entry>.generate(7, createEntry);

  void routeCreateEntry(title, content) {
    setState(() {
      entries.add(new Entry(title: title, content: content));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        if (index > entries.length) return null;
        if (index == entries.length) return TestInkwellWidget();
        return _buildRow(context, entries[index]);
      }),
    );
  }
}

Widget _buildRow(context, Entry entry) {
  return ListTile(
    title: Text(entry.title),
    subtitle: Text(entry.getDateString()),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(entry: entry),
        ),
      );
    },
  );
}

class FirstRoute extends StatefulWidget {
  @override
  FirstRouteState createState() => FirstRouteState();
}
