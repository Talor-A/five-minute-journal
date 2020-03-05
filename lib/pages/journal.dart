import 'package:flutter/material.dart';
import 'package:june_lake/api/log_service.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/model/todo.dart';
import 'package:june_lake/widgets/editor.dart';
import 'package:june_lake/widgets/todo_item.dart';
import 'package:provider/provider.dart';

class Journal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Logs(),
      persistentFooterButtons: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width, child: Editor())
      ],
    );
  }
}

class Logs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var entries = Provider.of<List<Log>>(context);

    if (entries == null) return Text('loading...');

    return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(context, index);
        });
  }
}

Widget _buildLogItem(Log log) {
  if (Todo.isTodo(log)) {
    return TodoItem(log, onTap: () {
      Todo.toggle(log);
      logService.update(log);
    });
  } else {
    return ListTile(
      leading: Text('–'),
      title: Text(log.text),
      onTap: () {},
    );
  }
}

Widget _buildRow(context, int index) {
  var entries = Provider.of<List<Log>>(context);
  Log log = entries[index];
  Widget tile = _buildLogItem(log);

  // add date header to first item of a certain date.
  //hack in lieu of a proper sectioned list.
  if (index == 0 || log.dateString != entries[index - 1].dateString) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            log.dateString,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          padding: EdgeInsets.only(left: 16),
        ),
        tile,
      ],
    );
  }

  return tile;
}
