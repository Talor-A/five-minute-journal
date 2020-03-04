import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:june_lake/model/log.dart';

class TextEntry extends Log {
  @override
  factory TextEntry.fromSnap(DocumentSnapshot snap) {
    Log log = Log.fromSnap(snap);
    log.type = 'text';
    return log;
  }
  @override
  Map<String, dynamic> toMap() {
    var m = super.toMap();
    m['type'] = 'text';
    return m;
  }
}
