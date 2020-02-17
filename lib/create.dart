import 'main.dart';
import 'package:flutter/material.dart';

String contentPlaceholder = '''today, my mood was: 😌
one word to describe my feelings: content
''';

class CreatePageState extends State {
  Entry entry;
  TextEditingController _content;
  TextEditingController _title;
  Function createFunc;

  CreatePageState(this.entry, this.createFunc);

  @override
  void initState() {
    super.initState();
    _title = new TextEditingController(text: 'My Day');
    _content = new TextEditingController(text: contentPlaceholder);
  }

  @override
  void dispose() {
    _content.dispose();
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var titleField = TextField(
      autocorrect: true,
      onChanged: (value) => this.setState(() {
        entry.title = value;
      }),
      controller: _title,
      maxLines: 1,
      autofocus: true,
    );
    var contentField = TextField(
      autocorrect: true,
      onChanged: (value) => this.setState(() {
        entry.content = value;
      }),
      controller: _content,
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
        child: Column(children: [
          titleField,
          contentField,
        ]),
      ),
      floatingActionButton: _content.text.length > 0 && _title.text.length > 0
          ? FloatingActionButton(
              onPressed: () {
                createFunc(_title.text, _content.text);
                Navigator.pop(context);
              },
              child: Icon(Icons.done),
            )
          : null,
    );
  }
}

class CreatePage extends StatefulWidget {
  final Entry entry = new Entry('', '');
  Function createFunc;

  CreatePage(this.createFunc);

  CreatePageState createState() => CreatePageState(entry, createFunc);
}
