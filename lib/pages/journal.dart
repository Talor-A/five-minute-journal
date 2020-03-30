import 'package:flutter/material.dart';
import 'package:june_lake/api/log_service.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/pages/timed_page.dart';
import 'package:june_lake/widgets/text_item.dart';
import 'package:provider/provider.dart';

class Journal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Logs(),
      // persistentFooterButtons: <Widget>[
      //   SizedBox(
      //       width: MediaQuery.of(context).size.width,
      //       child: Editor(
      //         showBar: false,
      //       ))
      // ],
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'fab-no-timer',
            tooltip: 'write without a timer',
            child: Icon(Icons.alarm_off),
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.black,
            mini: true,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimedPage(customTime: 0),
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: 'fab-timed-writing',
            child: Icon(Icons.edit),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => TimedPage())),
          ),
        ],
      ),
    );
  }
}

class Logs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var entries = Provider.of<List<Log>>(context);

    if (entries == null) return Text('loading...');

    return ListView.builder(
        reverse: true,
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(context, index);
        });
  }
}

Widget _buildLogItem(BuildContext context, Log log) {
  switch (log.type) {
    case "text":
    // return TextItem(log, onDeletePressed: () => logService.delete(log));
    default:
      return TextItem(
        log,
        onDeletePressed: () => logService.delete(log),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimedPage(
              customTime: 0,
              log: log,
            ),
          ),
        ),
      );
  }
}

Widget _buildRow(context, int index) {
  var entries = Provider.of<List<Log>>(context);
  Log log = entries[index];
  Widget tile = _buildLogItem(context, log);

  // add date header to first item of a certain date.
  //hack in lieu of a proper sectioned list.
  if (index == entries.length - 1 ||
      log.dateString != entries[index + 1].dateString) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            log.dateString,
            style: Theme.of(context)
                .textTheme
                .body2
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          padding: EdgeInsets.only(left: 16),
        ),
        tile,
      ],
    );
  }

  return tile;
}
