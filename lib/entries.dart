import 'dart:math';

import 'package:flutter/material.dart';
import 'package:june_lake/model/entry.dart';
import 'package:june_lake/model/user.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EntriesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Details(entry: Entry(creationDate: DateTime.now())),
            ),
          );
        },
      ),
    );
  }
}

class EntriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var entries = Provider.of<List<Entry>>(context);

    if (entries == null) return Text('loading...');

    return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(context, entries[index]);
        });
  }
}

Widget _buildRow(context, Entry entry) {
  return ListTile(
    title: Text(entry.date()),
    subtitle: Text(entry.content.substring(0, min(entry.content.length, 50))),
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
