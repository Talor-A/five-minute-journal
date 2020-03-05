import 'package:flutter/material.dart';
import 'package:june_lake/model/log.dart';
import 'package:menu/menu.dart';

class TextItem extends StatelessWidget {
  final Log log;
  final void Function() onDeletePressed;

  const TextItem(this.log, {Key key, this.onDeletePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Menu(
      items: [MenuItem('delete', this.onDeletePressed)],
      child: ListTile(
        leading: Text('–'),
        title: Text(log.text),
        onTap: () {},
      ),
    );
  }
}
