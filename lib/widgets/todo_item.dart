import 'package:flutter/material.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/model/todo.dart';

class TodoItem extends StatelessWidget {
  final void Function() onTap;
  final Log log;

  TodoItem(this.log, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Todo.isComplete(log)
          ? Icon(Icons.check)
          : Text(
              '•',
              style:
                  TextStyle(color: Theme.of(context).textTheme.caption.color),
            ),
      title: Text(log.text),
      onTap: this.onTap,
    );
  }
}
