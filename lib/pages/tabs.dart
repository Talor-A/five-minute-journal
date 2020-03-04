import 'package:flutter/material.dart';
import 'package:june_lake/pages/agenda.dart';
import 'package:june_lake/pages/journal.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Container(
            color: Theme.of(context).primaryColorDark,
            child: SafeArea(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: ShapeDecoration(
                      color: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(44.0)),
                      )),
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Theme.of(context).disabledColor,
                    tabs: [
                      Tab(
                        text: 'Journal',
                      ),
                      Tab(
                        text: 'Agenda',
                      ),
                    ],
                  )),
            ),
          ),
        ),
        body: TabBarView(
          // physics: NeverScrollableScrollPhysics(),
          children: [
            Journal(),
            Agenda(),
          ],
        ),
      ),
    );
  }
}
