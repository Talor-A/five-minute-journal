import 'main.dart';
import 'package:flutter/material.dart';

class CreatePageState extends State {
  Entry entry;
  TextEditingController _controller;

  CreatePageState(this.entry);

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: '');
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
      autofocus: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: textf,
      ),
      floatingActionButton: _controller.text.length > 0
          ? FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.done),
            )
          : null,
    );
  }
}

class CreatePage extends StatefulWidget {
  final Entry entry = new Entry('', '');

  CreatePage({Key key});

  CreatePageState createState() => CreatePageState(entry);
}
