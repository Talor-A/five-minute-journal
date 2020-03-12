import 'package:flutter/material.dart';
import 'package:june_lake/api/log_service.dart';
import 'package:june_lake/widgets/chips.dart';

class EditorState extends State {
  String content = '';
  int selectedItem = 0;
  final List<String> options = ["note", "todo"];

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
    switch (options[selectedItem]) {
      case "note":
        logService.newLog(content);
        break;
      case "todo":
        logService.newTodo(content);
        break;
      default:
        print("allow me to introduce myself. I am an error.");
        break;
    }

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Chips(selectedItem, options, (index) {
            this.setState(() {
              this.selectedItem = index;
            });
          }),
          Container(
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
          )
        ],
      ),
    );
  }
}

class Editor extends StatefulWidget {
  EditorState createState() => EditorState();
}
