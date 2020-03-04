import 'package:flutter/material.dart';
import 'package:june_lake/api/log_service.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/model/todo.dart';
import 'package:provider/provider.dart';

class Agenda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Logs(),
      persistentFooterButtons: <Widget>[
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Expanded(child: TextField()),
                  FlatButton(
                    onPressed: null,
                    child: Icon(Icons.keyboard_arrow_up),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

class Logs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var entries = Provider.of<List<Log>>(context);
    entries = entries.toList();
    entries.retainWhere((Log test) {
      return test.type == 'todo';
    });

    if (entries == null) return Text('loading...');

    return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(context, entries[index]);
        });
  }
}

Widget _buildRow(context, Log log) {
  print('built row $log');
  Widget tile;

  if (Todo.isTodo(log)) {
    tile = ListTile(
      leading: Text('•'),
      title: Text(log.text),
      onTap: () {
        Todo.toggle(log);
        logService.update(log);
      },
      trailing: Todo.isComplete(log) ? Icon(Icons.check) : null,
    );
  } else {
    tile = ListTile(
      leading: Text('–'),
      title: Text(log.text),
      onTap: () {},
    );
  }

  // if (index == 0 || log.dateString != entries[index - 1].dateString) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         child: Text(
  //           log.dateString,
  //           style: TextStyle(color: Theme.of(context).primaryColor),
  //         ),
  //         padding: EdgeInsets.only(left: 16),
  //       ),
  //       tile,
  //     ],
  //   );
  // }

  return tile;
}
