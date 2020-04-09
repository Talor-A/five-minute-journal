import 'package:flutter/material.dart';
import 'package:fiveminutejournal/api/log_service.dart';
import 'package:fiveminutejournal/provider/theme_provider.dart';
import 'package:fiveminutejournal/widgets/chips.dart';
import 'package:provider/provider.dart';

class EditorState extends State {
  String content = '';
  TimeOfDay _time;
  DateTime _date;
  int selectedItem;
  bool showBar;
  final List<String> options = ["note", "todo"];

  TextEditingController _controller;

  EditorState({this.selectedItem = 0, this.showBar = true}) : super();

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

  DateTime get dueDate {
    var now = DateTime.now();

    if (_date == null && _time == null)
      return null;
    else if (_date != null && _time == null)
      return _date;
    else if (_time != null && _date == null)
      return DateTime(
        now.year,
        now.month,
        now.day,
        _time.hour,
        _time.minute,
      );
    else {
      assert(_date != null && _time != null);
      return DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      );
    }
  }

  bool get isTodoEditor {
    return options[selectedItem] == "todo";
  }

  bool get isNoteEditor {
    return options[selectedItem] == "note";
  }

  pickDate() async {
    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 2),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Provider.of<ThemeProvider>(context).currentThemeData,
          child: child,
        );
      },
    );
    setState(() {
      _date = selectedDate ?? _date;
    });
  }

  pickTime() async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Provider.of<ThemeProvider>(context).currentThemeData.copyWith(
              backgroundColor: Provider.of<ThemeProvider>(context)
                  .currentThemeData
                  .canvasColor),
          child: child,
        );
      },
    );
    setState(() {
      _time = selectedTime ?? _time;
    });
  }

  bool get canSubmit => this.content.length > 0;

  void submit() {
    switch (options[selectedItem]) {
      case "note":
        logService.newLog(content);
        break;
      case "todo":
        logService.newTodo(content, dueDate: dueDate);
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

  Widget _buildChips(BuildContext context) {
    return Container(
        child: Chips(selectedItem, options, (index) {
      this.setState(() {
        this.selectedItem = index;
      });
    }));
  }

  Widget _buildTodoRow(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: this.pickDate,
        ),
        IconButton(
          icon: Icon(Icons.access_time),
          onPressed: this.pickTime,
        ),
        if (this.dueDate != null) Text("due " + dueDate.toString()),
      ],
    );
  }

  Widget _buildInput(BuildContext context) {
    var textf = TextField(
      autocorrect: true,
      onChanged: this.setText,
      controller: _controller,
      decoration: InputDecoration(border: InputBorder.none),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );

    return Row(
      children: [
        Expanded(
          child: textf,
        ),
        IconButton(
          color: this.canSubmit ? null : Theme.of(context).disabledColor,
          onPressed: this.canSubmit ? this.submit : null,
          icon: Icon(Icons.keyboard_arrow_up),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.showBar) _buildChips(context),
          if (this.isTodoEditor) _buildTodoRow(context),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: _buildInput(context),
          ),
        ],
      ),
    );
  }
}

class Editor extends StatefulWidget {
  final bool showBar;
  final int selectedItem;

  const Editor({
    Key key,
    this.showBar = true,
    this.selectedItem = 0,
  }) : super(key: key);

  EditorState createState() =>
      EditorState(showBar: this.showBar, selectedItem: this.selectedItem);
}
