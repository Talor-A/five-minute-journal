import 'package:flutter/material.dart';
import 'package:june_lake/model/log.dart';
import 'package:menu/menu.dart';

class TextItem extends StatelessWidget {
  final Log log;
  final void Function() onDeletePressed;
  final double paddingTop;
  final double paddingBottom;

  const TextItem(this.log,
      {Key key,
      this.onDeletePressed,
      this.paddingTop = 16.0,
      this.paddingBottom = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Menu(
      items: [MenuItem('delete', this.onDeletePressed)],
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('–'),
              ),
              Text(
                log.text,
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
