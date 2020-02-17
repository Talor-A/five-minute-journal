import 'main.dart';
import 'package:flutter/material.dart';

class DetailsState extends State {
  final Entry entry;
  TextEditingController _controller;

  DetailsState(this.entry);

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: entry.content);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textf = TextField(
      autocorrect: true,
      onChanged: (value) => this.setState(() {
        entry.content = value;
      }),
      controller: _controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: textf,
      ),
    );
  }
}

class Details extends StatefulWidget {
  final Entry entry;

  Details({Key key, @required this.entry});

  DetailsState createState() => DetailsState(entry);
}
