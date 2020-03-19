import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:june_lake/api/log_service.dart';
import 'package:june_lake/model/log.dart';
import 'package:june_lake/model/todo.dart';
import 'package:june_lake/widgets/custom_keyboard.dart';
import 'package:june_lake/widgets/mood_item.dart';
import 'package:june_lake/widgets/todo_item.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

var dateUtil = DateUtil();

class MoodTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int month = DateTime.now().month;
    int year = DateTime.now().year;

    int daysThisMonth = dateUtil.daysInMonth(month, year);

    var entries = Provider.of<List<Log>>(context);
    entries = entries.toList();
    entries.retainWhere((Log test) {
      return test.type == 'mood' && test.createdAt.month == month;
    });

    if (entries == null) return Text('loading...');

    List<Log> entriesToDate = List<Log>(daysThisMonth);

    entries.forEach((Log e) => entriesToDate[e.createdAt.day - 1] = e);
    // return Content();
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateFormat("LLLL").format(DateTime.now()).toLowerCase() +
                ' mood tracker',
            style: Theme.of(context).textTheme.display1,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: daysThisMonth,
                itemBuilder: (BuildContext context, int index) {
                  return _buildRow(context, entriesToDate[index], index);
                }),
          )
        ],
      ),
    );
  }
}

Widget _buildRow(context, Log mood, int index) {
  return Row(
    children: <Widget>[
      Text('${index + 1}'),
      mood != null ? MoodItem(mood) : Container()
    ],
  );
}

//This could be StatelessWidget but it won't work on Dialogs for now until this issue is fixed: https://github.com/flutter/flutter/issues/45839
class Content extends StatefulWidget {
  final bool isDialog;

  const Content({Key key, this.isDialog = false}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final FocusNode _nodeText1 = FocusNode();

  final FocusNode _nodeText2 = FocusNode();

  final FocusNode _nodeText3 = FocusNode();

  final FocusNode _nodeText4 = FocusNode();

  final FocusNode _nodeText5 = FocusNode();

  final FocusNode _nodeText6 = FocusNode();

  final FocusNode _nodeText7 = FocusNode();

  final FocusNode _nodeText8 = FocusNode();

  final FocusNode _nodeText9 = FocusNode();

  final FocusNode _nodeText10 = FocusNode();

  final custom1Notifier = ValueNotifier<String>("0");

  final custom2Notifier = ValueNotifier<Color>(Colors.blue);

  final custom3Notifier = ValueNotifier<String>("");

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Theme.of(context).canvasColor,
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
        ),
        KeyboardAction(focusNode: _nodeText2, toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.close),
              ),
            );
          }
        ]),
        KeyboardAction(
          focusNode: _nodeText3,
          onTapAction: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Custom Action"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                });
          },
        ),
        KeyboardAction(
          focusNode: _nodeText4,
          displayDoneButton: false,
        ),
        KeyboardAction(
          focusNode: _nodeText5,
          toolbarButtons: [
            //button 1
            (node) {
              return GestureDetector(
                onTap: () => node.nextFocus(),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "CLOSE",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
            //button 2
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "DONE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          ],
        ),
        KeyboardAction(
          focusNode: _nodeText6,
          footerBuilder: (_) => PreferredSize(
              child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text('Custom Footer'),
                  )),
              preferredSize: Size.fromHeight(40)),
        ),
        KeyboardAction(
          focusNode: _nodeText7,
          displayActionBar: false,
          footerBuilder: (_) => PreferredSize(
              child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text('Custom Footer'),
                  )),
              preferredSize: Size.fromHeight(40)),
        ),
        KeyboardAction(
          focusNode: _nodeText9,
          footerBuilder: (_) => ColorPickerKeyboard(
            notifier: custom2Notifier,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      isDialog: widget.isDialog,
      config: _buildConfig(context),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                focusNode: _nodeText1,
                decoration: InputDecoration(
                  hintText: "Input Number",
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                focusNode: _nodeText2,
                decoration: InputDecoration(
                  hintText: "Input Text with Custom Done Widget",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                focusNode: _nodeText3,
                decoration: InputDecoration(
                  hintText: "Input Number with Custom Action",
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                focusNode: _nodeText4,
                decoration: InputDecoration(
                  hintText: "Input Text without Done Button",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                focusNode: _nodeText5,
                decoration: InputDecoration(
                  hintText: "Input Number with Toolbar Buttons",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                focusNode: _nodeText6,
                decoration: InputDecoration(
                  hintText: "Input Number with Custom Footer",
                ),
              ),
              TextField(
                focusNode: _nodeText7,
                decoration: InputDecoration(
                  hintText: "Input Number with Custom Footer without Bar",
                ),
              ),
              KeyboardCustomInput<String>(
                focusNode: _nodeText8,
                height: 65,
                notifier: custom1Notifier,
                builder: (context, val, hasFocus) {
                  return Container(
                    alignment: Alignment.center,
                    color: hasFocus ? Colors.grey[300] : Colors.white,
                    child: Text(
                      val,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              KeyboardCustomInput<Color>(
                focusNode: _nodeText9,
                height: 65,
                notifier: custom2Notifier,
                builder: (context, val, hasFocus) {
                  return Container(
                    width: double.maxFinite,
                    color: val ?? Colors.transparent,
                  );
                },
              ),
              KeyboardCustomInput<String>(
                focusNode: _nodeText10,
                height: 65,
                notifier: custom3Notifier,
                builder: (context, val, hasFocus) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      val.isEmpty ? "Tap Here" : val,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
