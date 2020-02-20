import 'package:flutter/material.dart';
import 'package:june_lake/model/entry.dart';

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
    this.entry.update();
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
      decoration: InputDecoration(border: InputBorder.none),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(entry.date()),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Notes',
              style: Theme.of(context).textTheme.headline,
            ),
            textf,
            Text(
              'Todos',
              style: Theme.of(context).textTheme.headline,
            ),
            Text('Todos: still todo! 😯')
          ],
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  final Entry entry;

  Details({Key key, @required this.entry});

  DetailsState createState() => DetailsState(entry);
}
