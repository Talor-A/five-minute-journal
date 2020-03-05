import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/model/log.dart';

class LogService {
  final Firestore _db;

  LogService(this._db);

  Stream<List<Log>> asList() {
    return getUserLogs()
        .orderBy('created_at')
        .snapshots()
        .map((list) => list.documents.map((doc) => Log.fromSnap(doc)).toList());
  }

  Future<void> update(Log e) async {
    return getUserLogs().document(e.uid).updateData(e.toMap());
  }

  void delete(Log e) async {
    return getUserLogs().document(e.uid).delete();
  }

  CollectionReference getUserLogs() {
    return this
        ._db
        .collection('users')
        .document(auth.getCurrentUser().uid)
        .collection('logs');
  }

  Future<DocumentReference> newLog(String text) {
    var log = Log(text: text);
    return getUserLogs().add(log.toMap());
  }
}

final LogService logService = LogService(Firestore.instance);
