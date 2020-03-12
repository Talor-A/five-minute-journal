import 'package:flutter/material.dart';
import 'package:june_lake/pages/agenda.dart';
import 'package:june_lake/pages/journal.dart';

class TabNavigator extends StatelessWidget {
  final Function() onDrawerTap;

  final tabs = [
    [
      Tab(text: 'Journal'),
      Journal(),
    ],
    [
      Tab(text: 'Agenda'),
      Agenda(),
    ],
  ];

  TabNavigator({Key key, this.onDrawerTap}) : super(key: key);

  Decoration _roundedCornerDecoration(BuildContext context) {
    return ShapeDecoration(
        color: Theme.of(context).canvasColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(44.0)),
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56.0),
      child: Container(
        color: Theme.of(context).canvasColor,
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            // decoration: _roundedCornerDecoration(context),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: FlatButton(
                    child: Icon(
                      Icons.menu,
                      color: Theme.of(context).disabledColor,
                    ),
                    onPressed: onDrawerTap,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TabBar(
                    indicatorColor: Theme.of(context).accentColor,
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Theme.of(context).disabledColor,
                    tabs: tabs.map((tab) => tab[0]).toList(),
                  ),
                )
              ],
            ),
          ),
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
          children: tabs.map((tab) => tab[1]).toList(),
        ),
      ),
    );
  }
}
