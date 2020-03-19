import 'package:flutter/material.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/model/todo.dart';
import 'package:menu/menu.dart';

class TodoItem extends StatelessWidget {
  final void Function() onTap;
  final void Function() onDeletePressed;
  final Log log;

  TodoItem(this.log, {Key key, this.onTap, this.onDeletePressed})
      : super(key: key);

  Widget _buildDueDateLabel(BuildContext context, Log log) {
    var style = Theme.of(context).textTheme.caption;

    if (!Todo.isIncomplete(log))
      style = style.copyWith(color: Theme.of(context).disabledColor);
    else if (log.dueDate.isBefore(DateTime.now()))
      style = style.copyWith(color: Colors.pinkAccent);

    return Text(
      log.dueDate.toString(),
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.body1;

    if (Todo.isComplete(log))
      textTheme = textTheme.copyWith(color: Theme.of(context).disabledColor);

    return Menu(
      items: [MenuItem('delete', this.onDeletePressed)],
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    Todo.isComplete(log) ? '×' : '•',
                    style: textTheme,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    log.text,
                    style: textTheme,
                  ),
                  if (log.dueDate != null) _buildDueDateLabel(context, log)
                ],
              )
            ],
          ),
        ),
        onTap: this.onTap,
      ),
    );
  }
}
