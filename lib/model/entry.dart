import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Entry {
  bool existsInDb;
  String id;
  String content;
  int mood;

  DocumentSnapshot snap;

  List<String> notes;

  DateTime _date;

  Entry({
    this.content,
    creationDate,
    this.id,
    this.mood,
    this.snap,
    existsInDb,
  }) {
    this.creationDate = creationDate;
    this.existsInDb = existsInDb ?? false;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();

    map['created_at'] = Timestamp.fromDate(creationDate);
    map['content'] = content;
    map['mood'] = mood;

    return map;
  }

  factory Entry.fromFirebase(DocumentSnapshot snap) {
    Map data = snap.data;
    var entry = Entry(
      id: snap.documentID,
      content: data['content'],
      creationDate: data['created_at'].toDate() ?? DateTime.now(),
      mood: data['mood'],
      snap: snap,
      existsInDb: true,
    );
    print(entry);
    return entry;
  }

  set creationDate(DateTime date) {
    if (date == null)
      throw PlatformException(code: 'fuck!!!', message: 'aaaagh!!');
    this._date = DateTime(date.year, date.month, date.day);
  }

  DateTime get creationDate => _date;

  String date() => DateFormat("MMMd").format(creationDate);

  DateTime getCalendarDate() => DateTime(
        creationDate.year,
        creationDate.month,
        creationDate.day,
      );

  String time() => DateFormat.jms().format(creationDate);

  @override
  String toString() => 'Entry for ${this.date()}';
  // void update() async {
  //   User user = await auth.currentUser.last;
  //   if (user != null) {
  //     print('updating $id');
  //     user
  //         .ref()
  //         .collection('entries')
  //         .document(this.id)
  //         .updateData({'content': this.content});
  //   } else {}
  // }

  // getTodayEntry() async {
  //   User user = await authService.currentUser.single;
  //   if (user != null) {
  //     var lastMidnight = DateTime.now();
  //     lastMidnight = lastMidnight.subtract(Duration(
  //       hours: lastMidnight.hour,
  //       minutes: lastMidnight.minute,
  //       seconds: lastMidnight.second,
  //       microseconds: lastMidnight.microsecond,
  //       milliseconds: lastMidnight.millisecond,
  //     ));

  //     print(DateFormat.yMMMd().add_jms().format(lastMidnight));
  //     var query = user
  //         .ref()
  //         .collection('entries')
  //         .where('created_at', isGreaterThan: lastMidnight);
  //     var docs = await query.getDocuments();
  //     var matches = docs.documents.length;
  //     print('matches: $matches');
  //     Stream<DocumentSnapshot> snap;
  //     if (matches == 0) {
  //       var ref = await user
  //           .ref()
  //           .collection('entries')
  //           .add(Entry(content: 'hello world!').toMap());
  //       snap = ref.snapshots();
  //     } else {
  //       snap = docs.documents[0].reference.snapshots();
  //     }
  //     return snap;
  //   }
  // }

}
