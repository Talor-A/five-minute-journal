import 'package:flutter/material.dart';

class TestInkwellWidget extends StatefulWidget {
  TestInkwellWidget({Key key}) : super(key: key);

  @override
  _TestInkwellWidgetState createState() => _TestInkwellWidgetState();
}

class _TestInkwellWidgetState extends State<TestInkwellWidget> {
  static final double expandedLength = 150;
  static final double collapsedLength = 50;

  double sideLength = collapsedLength;

  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: sideLength,
      width: sideLength,
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      child: Material(
        color: Colors.yellow,
        child: InkWell(
          onTap: () {
            setState(() {
              sideLength == collapsedLength
                  ? sideLength = expandedLength
                  : sideLength = collapsedLength;
            });
          },
        ),
      ),
    );
  }
}
