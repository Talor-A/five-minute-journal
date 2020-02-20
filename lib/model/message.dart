import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  static final String collection = 'messages';

  String text;
  DateTime createdAt;
  Message({this.text, this.createdAt, this.id});
  String id;

  factory Message.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data;

    return Message(
        text: data['message'],
        createdAt: data['created_at'].toDate(),
        id: snap.documentID);
  }

  Map<String, dynamic> _toMap() {
    Map<String, dynamic> map = Map();
    map['message'] = text;
    map['created_at'] = Timestamp.fromDate(createdAt);
    return map;
  }

  factory Message._fromMap(Map<String, dynamic> map, id) {
    Message msg = Message();
    msg.text = map['message'];
    msg.createdAt = map['created_at'].toDate();
    msg.id = id;
    return msg;
  }

  static Future<Message> create(text) async {
    Map<String, dynamic> map = Map();
    map['message'] = text;
    map['created_at'] = Timestamp.now();
    var ref = await Firestore.instance.collection(collection).add(map);
    var snap = await ref.get();

    Message msg = Message._fromMap(snap.data, ref.documentID);
    return msg;
  }

  update() {
    Firestore.instance
        .collection(collection)
        .document(this.id)
        .updateData(_toMap());
  }

  delete() {
    Firestore.instance.collection(collection).document(this.id).delete();
  }
}
