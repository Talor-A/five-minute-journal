import 'package:flutter/material.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/pages/mood_tracker.dart';
import 'package:june_lake/pages/todo_list.dart';
import 'package:june_lake/pages/journal.dart';
import 'package:provider/provider.dart';

class TabNavigator extends StatelessWidget {
  final Function() onDrawerTap;

  TabNavigator({Key key, this.onDrawerTap}) : super(key: key);

  List<List<Widget>> _getTabs(BuildContext context) {
    var list = Provider.of<List<Log>>(context)?.toList();
    list?.retainWhere(
        (log) => log.type == "todo" && log.status == TodoStatus.incomplete);

    int incompleteCount = list?.length ?? 0;

    var agendaTitle =
        incompleteCount == 0 ? 'Todos' : 'Todos ($incompleteCount)';

    return [
      [Tab(text: 'Journal'), Journal()],
      [Tab(text: agendaTitle), TodoList()],
      // [Tab(text: 'Mood Tracker'), MoodTracker()],
    ];
  }

  Widget _buildHeader(BuildContext context) {
    var titles = _getTabs(context).map((tab) => tab[0]).toList();

    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: Container(
        color: Theme.of(context).canvasColor,
        padding: EdgeInsets.only(right: 16.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            FlatButton(
              child: Icon(
                Icons.menu,
                color: Theme.of(context).disabledColor,
              ),
              onPressed: onDrawerTap,
              padding: EdgeInsets.all(0),
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
    var tabs = _getTabs(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildHeader(context),
        body: TabBarView(
          // physics: NeverScrollableScrollPhysics(),
          children: tabs.map((tab) => tab[1]).toList(),
        ),
      ),
    );
  }
}
