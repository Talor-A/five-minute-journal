import 'package:flutter/material.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/model/todo.dart';

class TodoItem extends StatelessWidget {
  final void Function() onTap;
  final Log log;

  TodoItem(this.log, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.body1;

    if (Todo.isComplete(log))
      textTheme = textTheme.copyWith(color: Theme.of(context).disabledColor);

    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                Todo.isComplete(log) ? '×' : '•',
                style: textTheme,
              ),
            ),
            Text(
              log.text,
              style: textTheme,
            ),
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
