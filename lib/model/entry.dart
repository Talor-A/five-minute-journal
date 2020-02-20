import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_day_1/model/user.dart';
import 'package:intl/intl.dart';

import 'Todo.dart';

class Entry {
  String id;
  String content;

  List<String> notes;
  List<Todo> todos;

  DateTime _date;

  set creationDate(DateTime date) {
    this._date = DateTime(date.year, date.month, date.day);
  }

  get creationDate => _date;

  Entry({content, creationDate, this.id}) {
    this.creationDate = DateTime.now();
    this.content = content != null ? content : '';
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();

    map['created_at'] = Timestamp.fromDate(creationDate);
    map['content'] = content;

    return map;
  }

  factory Entry.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data;

    return Entry(
      id: snap.documentID,
      content: data['content'],
      creationDate: data['created_at'].toDate(),
    );
  }

  void update() {
    User user = User();
    print('updating $id');
    user.doc
        .collection('entries')
        .document(this.id)
        .updateData({'content': this.content});
  }

  getTodayEntry(User user) async {
    var doc = user.doc;
    var lastMidnight = DateTime.now();
    lastMidnight = lastMidnight.subtract(Duration(
      hours: lastMidnight.hour,
      minutes: lastMidnight.minute,
      seconds: lastMidnight.second,
      microseconds: lastMidnight.microsecond,
      milliseconds: lastMidnight.millisecond,
    ));

    print(DateFormat.yMMMd().add_jms().format(lastMidnight));
    var query = doc
        .collection('entries')
        .where('created_at', isGreaterThan: lastMidnight);
    var docs = await query.getDocuments();
    var matches = docs.documents.length;
    print('matches: $matches');
    Stream<DocumentSnapshot> snap;
    if (matches == 0) {
      var ref = await doc
          .collection('entries')
          .add(Entry(content: 'hello world!').toMap());
      snap = ref.snapshots();
    } else {
      snap = docs.documents[0].reference.snapshots();
    }
    return snap;
  }

  String date() {
    return DateFormat("MMMd").format(creationDate);
  }

  DateTime getCalendarDate() {
    return DateTime(
      creationDate.year,
      creationDate.month,
      creationDate.day,
    );
  }

  String time() {
    return DateFormat.jms().format(creationDate);
  }
}
