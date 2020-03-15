import 'package:flutter/material.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/pages/todo_list.dart';
import 'package:june_lake/pages/journal.dart';
import 'package:provider/provider.dart';

class TabNavigator extends StatelessWidget {
  final Function() onDrawerTap;
  final tabs = [
    Journal(),
    TodoList(),
  ];

  TabNavigator({Key key, this.onDrawerTap}) : super(key: key);

  Widget _buildHeader(BuildContext context) {
    var list = Provider.of<List<Log>>(context)?.toList();
    list?.retainWhere(
        (log) => log.type == "todo" && log.status == TodoStatus.incomplete);

    int incompleteCount = list?.length ?? 0;

    var agendaTitle =
        incompleteCount == 0 ? 'Todos' : 'Todos ($incompleteCount)';
    var titles = [
      Tab(text: 'Journal'),
      Tab(text: agendaTitle),
    ];

    return PreferredSize(
      preferredSize: Size.fromHeight(56.0),
      child: Container(
        color: Theme.of(context).canvasColor,
        padding: EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            FlatButton(
              child: Icon(
                Icons.menu,
                color: Theme.of(context).disabledColor,
              ),
              onPressed: onDrawerTap,
            ),
            Expanded(
              flex: 1,
              child: TabBar(
                indicatorColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Theme.of(context).disabledColor,
                tabs: titles,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildHeader(context),
        body: TabBarView(
          // physics: NeverScrollableScrollPhysics(),
          children: tabs,
        ),
      ),
    );
  }
}
