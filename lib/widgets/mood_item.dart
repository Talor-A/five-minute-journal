import 'package:flutter/material.dart';
import 'package:june_lake/model/log.dart';
import 'package:menu/menu.dart';

class MoodItem extends StatelessWidget {
  final Log log;
  final void Function() onDeletePressed;
  final double paddingTop;
  final double paddingBottom;

  const MoodItem(this.log,
      {Key key,
      this.onDeletePressed,
      this.paddingTop = 16.0,
      this.paddingBottom = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Menu(
      items: [MenuItem('delete', this.onDeletePressed)],
      child: Chips(log.text.split(" "), (_i) {}),
    );
  }
}

class Chips extends StatelessWidget {
  final List<String> items;
  final Function(int index) onSelected;

  const Chips(
    this.items,
    this.onSelected, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        children: List<Widget>.generate(
          items.length + 1,
          (int index) {
            if (index == items.length)
              return MyCircleButton(
                color: Theme.of(context).chipTheme.labelStyle.color,
                backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                icon: Icons.add,
                onPressed: () => print('pressed!'),
              );
            return ChoiceChip(
              selectedColor: Colors.indigoAccent,
              label: Text(items[index]),
              selected: true,
              onSelected: (bool selected) {
                this.onSelected(index);
              },
            );
          },
        ).toList(),
      ),
    );
  }
}

class MyCircleButton extends StatelessWidget {
  final Function() onPressed;
  final Color color;
  final Color backgroundColor;
  final IconData icon;
  final double size;
  final double padding;

  const MyCircleButton({
    Key key,
    this.onPressed,
    this.size = 32.0,
    this.color = Colors.white,
    this.backgroundColor = Colors.blue,
    this.icon = Icons.add,
    this.padding = 8.0,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: Ink(
        width: size,
        height: size,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: CircleBorder(),
        ),
        child: IconButton(
          padding: EdgeInsets.all(0.0),
          icon: Icon(
            icon,
            size: size / 2,
          ),
          color: color,
          onPressed: this.onPressed,
        ),
      ),
    );
  }
}
