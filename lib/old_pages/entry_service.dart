import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'entry.dart';
import 'package:june_lake/api/auth.dart';
import 'package:june_lake/model/user.dart';

class EntryService {
  final Firestore _db;

  EntryService(this._db);

  Stream<List<Entry>> asList() {
    return getCurrentUserEntries().snapshots().map((list) =>
        list.documents.map((doc) => Entry.fromFirebase(doc)).toList());
  }

  void update(Entry e) async {
    if (!e.existsInDb) {
      var ref = getCurrentUserEntries().document();
      e.existsInDb = true;
      e.id = ref.documentID;
      return ref.setData(e.toMap());
    }
    return getCurrentUserEntries().document(e.id).updateData(e.toMap());
  }

  void delete(Entry e) async {
    return getCurrentUserEntries().document(e.id).delete();
  }

  CollectionReference getCurrentUserEntries() {
    return this
        ._db
        .collection('users')
        .document(auth.getCurrentUser().uid)
        .collection('entries');
  }

  getForDate(DateTime date) async {
    User user = auth.getCurrentUser();

    if (user != null) {
      var lastMidnight = DateTime(date.year, date.month, date.day);
      lastMidnight = lastMidnight.subtract(Duration(
        hours: lastMidnight.hour,
        minutes: lastMidnight.minute,
        seconds: lastMidnight.second,
        microseconds: lastMidnight.microsecond,
        milliseconds: lastMidnight.millisecond,
      ));

      print(DateFormat.yMMMd().add_jms().format(lastMidnight));
      var query = entryService
          .getCurrentUserEntries()
          .where('created_at', isEqualTo: lastMidnight);
      var docs = await query.getDocuments();
      var matches = docs.documents.length;
      print('matches: $matches');
      Stream<DocumentSnapshot> snap;
      if (matches == 0) {
        var ref = await entryService
            .getCurrentUserEntries()
            .add(Entry(content: 'hello world!').toMap());
        snap = ref.snapshots();
      } else {
        snap = docs.documents[0].reference.snapshots();
      }
      return snap;
    }
  }
}

final EntryService entryService = EntryService(Firestore.instance);
