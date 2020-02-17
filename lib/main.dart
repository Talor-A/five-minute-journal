import 'package:flutter/material.dart';
import 'package:flutter_day_1/create.dart';
import 'details.dart';

void main() => runApp(MyApp());

final months = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec',
};

final days = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};

class Entry {
  String title;
  String content;
  DateTime creationDate;

  Entry(this.title, this.content) {
    this.creationDate = DateTime.now();
  }

  String getDateString() =>
      "${days[creationDate.weekday]} " +
      "${months[creationDate.month]} ${creationDate.day}, ${creationDate.year} @ " +
      "${creationDate.hour}:${creationDate.minute.toString().padLeft(2, "0")}";
}

Entry createEntry(int index) {
  return Entry('Entry $index', 'entry content');
}

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
  var entries = List<Entry>.generate(1, createEntry);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePage()));
          // setState(() {
          //   entries.add(createEntry(entries.length));
          // });
        },
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        if (index >= entries.length) return null;
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
