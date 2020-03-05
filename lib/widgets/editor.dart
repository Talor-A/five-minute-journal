import 'package:flutter/material.dart';
import 'package:june_lake/api/log_service.dart';

class EditorState extends State {
  String content = '';
  TextEditingController _controller;

  EditorState();

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void submit() {
    logService.newLog(this.content);
    //for some reason both of these are needed. probs a bug.
    _controller.clear();
    this.setText('');
  }

  void setText(String value) => this.setState(() {
        // print('val: $value');
        this.content = value;
      });
  @override
  Widget build(BuildContext context) {
    var textf = TextField(
      autocorrect: true,
      onChanged: this.setText,
      controller: _controller,
      decoration: InputDecoration(border: InputBorder.none),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );

    return Container(
      padding: EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Expanded(child: textf),
          FlatButton(
            color: this.content.length > 0
                ? null
                : Theme.of(context).disabledColor,
            onPressed: this.content.length > 0 ? this.submit : null,
            child: Icon(Icons.keyboard_arrow_up),
          ),
        ],
      ),
    );
  }
}

class Editor extends StatefulWidget {
  EditorState createState() => EditorState();
}
