import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_day_1/data/entry.dart';

class User {
  String id;
  DocumentReference doc;
  DocumentSnapshot snap;
  String data;

  static Stream<User> getById(String userID) {
    print('getting for user $userID');
    var doc = Firestore.instance.collection('users').document(userID);
    var stream = doc.snapshots();

    return stream.asyncMap((DocumentSnapshot snap) async {
      User user = User();
      user.id = snap.documentID;
      if (!snap.exists) {
        doc.setData(
            {'name': (await FirebaseAuth.instance.currentUser()).displayName});
      }
      user.snap = snap;
      user.doc = doc;
      user.data = snap.data.toString();
      return user;
    });
  }

  Stream<List<Entry>> getEntries() {
    return doc.collection('entries').snapshots().map((list) =>
        list.documents.map((doc) => Entry.fromSnapshot(doc)).toList());
  }

  static Stream<User> get(FirebaseUser authUser) {
    if (authUser == null) return null;
    return getById(authUser.uid);
  }
}
