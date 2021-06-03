import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fiveminutejournal/api/log_service.dart';
import 'package:fiveminutejournal/model/log.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' as VectorMath;

class TimedPage extends StatefulWidget {
  final Log log;
  final double customTime;

  const TimedPage({Key key, this.log, this.customTime}) : super(key: key);

  @override
  TimedPageState createState() =>
      TimedPageState(log: this.log, customTime: this.customTime);
}

class TimedPageState extends State with TickerProviderStateMixin {
  AnimationController angerTimer;
  AnimationController writingTimer;
  TextEditingController inputController;
  Random rng = Random();
  Log log;

  bool hasTimer = true;
  bool _didShowNoTimerMessage = false;

  // workaround via https://stackoverflow.com/q/51304568
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TimedPageState({Log log, double customTime}) {
    if (customTime != null) {
      if (customTime == 0) {
        hasTimer = false;
      }
    }
    this.log = log ?? new Log(text: "");
  }

  @override
  void initState() {
    super.initState();

    inputController = TextEditingController(text: log.text);

    writingTimer = AnimationController(
      vsync: this,
      duration: Duration(minutes: 3),
      lowerBound: 0.0,
      upperBound: 1.0,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener(_checkWritingTimerFinished);
    angerTimer = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
      lowerBound: 0.0,
      upperBound: 1.0,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          writingTimer.stop();
          _whenAngerWins();
        }
      });
    angerTimer.value = 0.0;
  }

  void _checkWritingTimerFinished(status) {
    if (status == AnimationStatus.completed) {
      angerTimer.reset();
      final snackBar = SnackBar(
          content:
              Text('Great job!! you finished. feel free to keep writing.'));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
      _scaffoldKey.currentState.showSnackBar(snackBar);
      if (log.existsInDb == false) {
        logService
            .newLog(log.text)
            .then((ref) async => Log.fromSnap(await ref.get()))
            .then((log) => this.log = log);
      }
    }
  }

  void _showNoTimerMessage() {
    final snackBar = SnackBar(
        content: Text(
            'There\'s no timer set. write whatever your heart desires :)'));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
    _scaffoldKey?.currentState?.showSnackBar(snackBar);
  }

  @override
  void dispose() {
    print('disposing timer page');

    inputController?.dispose();

    writingTimer?.stop(canceled: true);
    writingTimer?.dispose();
    angerTimer?.stop(canceled: true);
    angerTimer?.dispose();

    super.dispose();
  }

  bool get writingTimerIsRunning =>
      writingTimer.status != AnimationStatus.forward;
  double get _angerAmount => max(0.0, (angerTimer.value * 2) - 1);

  double _randDouble() => (rng.nextDouble() * 2) - 1;

  VectorMath.Vector3 _shake() {
    double s = 12;
    return VectorMath.Vector3(
      _randDouble() * _angerAmount * s,
      _randDouble() * _angerAmount * s,
      _randDouble() * _angerAmount * s,
    );
  }

  void _onTextChange(String newText) {
    this.setState(() {
      log.text = newText;
      if (log.existsInDb) {
        print('updating log ${log.snap.documentID}');
        logService.update(log);
      }
    });
    angerTimer.value = 0.0;
    if (hasTimer) {
      if (!writingTimer.isCompleted) angerTimer.forward();
      writingTimer.forward();
    }
    if (!hasTimer && !_didShowNoTimerMessage) {
      _didShowNoTimerMessage = true;
      if (log.existsInDb == false) {
        logService
            .newLog(log.text)
            .then((ref) async => Log.fromSnap(await ref.get()))
            .then((log) => this.log = log);
      }
      Future.delayed(const Duration(seconds: 1)).then((_) {
        _showNoTimerMessage();
      });
    }
  }

  Future<void> _whenAngerWins() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Sometimes you eat the bear, and sometimes, well, the bear eats you.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Rewind and Retry'),
              onPressed: () {
                Navigator.of(context).pop();
                inputController.text = '';
                angerTimer.reset();
                writingTimer.reset();
              },
            ),
            FlatButton(
              child: Text('Go Home'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      controller: inputController,
      autofocus: true,
      onChanged: _onTextChange,
      // enableInteractiveSelection: false,
      decoration: InputDecoration(border: InputBorder.none),
      expands: true,
      minLines: null,
      maxLines: null,
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (!writingTimerIsRunning) return Text('');
    int maxTime = writingTimer.duration.inSeconds;
    int currentTime = (maxTime * (1 - writingTimer.value)).floor();
    int minutes = (currentTime / 60).floor();
    int seconds = currentTime % 60;
    NumberFormat secFormat = NumberFormat('00');
    return Text('$minutes:${secFormat.format(seconds)}');
  }

  Future<bool> _handleGoBack() async {
    if (writingTimerIsRunning) return true;

    final snackBar = SnackBar(
      content: Text("Can't leave! Your timer is running!"),
    );
    _scaffoldKey?.currentState?.showSnackBar(snackBar);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleGoBack,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: _buildTitle(context),
          backgroundColor: ColorTween(
            begin: Theme.of(context).appBarTheme.color,
            end: Colors.red,
          ).lerp(_angerAmount),
        ),
        body: Column(children: [
          if (hasTimer)
            LinearProgressIndicator(
              value: writingTimer.value,
              backgroundColor: ColorTween(
                begin: Theme.of(context).backgroundColor,
                end: Colors.red,
              ).lerp(_angerAmount),
            ),
          Expanded(
            child: Container(
              color: ColorTween(
                begin: Theme.of(context).canvasColor,
                end: Colors.red,
              ).lerp(_angerAmount),
              padding: EdgeInsets.all(16.0),
              child: Transform(
                transform: Matrix4.translation(_shake()),
                child: _buildTextField(context),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

/*

1    1    1   .75  .5
|----|----|----|----|
0   .25  .5   .75   1
*/
