import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_day_1/data/Entry.dart';
import 'package:flutter_day_1/widget/test.dart';

import 'details.dart';

class FirstRouteState extends State<FirstRoute> {
  var entries = List<Entry>();

  void routeCreateEntry(title, content) {
    setState(() {
      entries.add(new Entry(content: content));
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
    title: Text(entry.date()),
    subtitle:
        Text(entry.content.substring(0, min(entry.content.length - 1, 50))),
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
