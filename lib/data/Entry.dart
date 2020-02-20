import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'Todo.dart';

class Entry {
  String content;

  List<String> notes;
  List<Todo> todos;

  DateTime creationDate;

  Entry({content, creationDate}) {
    this.creationDate = DateTime.now();
    this.content = content != null ? content : '';
  }

  factory Entry.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data;

    return Entry(
      content: data['content'],
      creationDate: data['created_at'].toDate(),
    );
  }

  String date() {
    return DateFormat("MMMd").format(creationDate);
  }

  String time() {
    return DateFormat.jms().format(creationDate);
  }
}
