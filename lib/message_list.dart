// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'data/message.dart';

class MessageList extends StatelessWidget {
  Widget build(BuildContext context) {
    var messages = Provider.of<List<Message>>(context);

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (_, int index) {
        final Message message = messages[index];

        var date = message.createdAt;

        var dateString =
            DateFormat("MMMd").addPattern("@").add_jm().format(date);

        return ListTile(
          trailing: IconButton(
            onPressed: () => message.delete(),
            icon: Icon(Icons.delete),
          ),
          title: Text(
            message != null ? message.text : '<No message retrieved>',
          ),
          subtitle: Text(dateString),
        );
      },
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   MyHomePage({this.firestore});

//   final Firestore firestore;

//   CollectionReference get messages => firestore.collection('messages');

//   Future<void> _addMessage() async {
//     await messages.add(<String, dynamic>{
//       'message': 'Hello world!',
//       'created_at': FieldValue.serverTimestamp(),
//     });
//   }

//   Future<void> _runTransaction() async {
//     firestore.runTransaction((Transaction transaction) async {
//       final allDocs = await firestore.collection("messages").getDocuments();
//       final toBeRetrieved =
//           allDocs.documents.sublist(allDocs.documents.length ~/ 2);
//       final toBeDeleted =
//           allDocs.documents.sublist(0, allDocs.documents.length ~/ 2);
//       await Future.forEach(toBeDeleted, (DocumentSnapshot snapshot) async {
//         await transaction.delete(snapshot.reference);
//       });

//       await Future.forEach(toBeRetrieved, (DocumentSnapshot snapshot) async {
//         await transaction.update(snapshot.reference, {
//           "message": "Updated from Transaction",
//           "created_at": FieldValue.serverTimestamp()
//         });
//       });
//     });

//     await Future.forEach(List.generate(2, (index) => index), (item) async {
//       await firestore.runTransaction((Transaction transaction) async {
//         await Future.forEach(List.generate(10, (index) => index), (item) async {
//           await transaction.set(firestore.collection("messages").document(), {
//             "message": "Created from Transaction $item",
//             "created_at": FieldValue.serverTimestamp()
//           });
//         });
//       });
//     });
//   }

//   Future<void> _runBatchWrite() async {
//     final batchWrite = firestore.batch();
//     final querySnapshot = await firestore
//         .collection("messages")
//         .orderBy("created_at")
//         .limit(12)
//         .getDocuments();
//     querySnapshot.documents
//         .sublist(0, querySnapshot.documents.length - 3)
//         .forEach((DocumentSnapshot doc) {
//       batchWrite.updateData(doc.reference, {
//         "message": "Batched message",
//         "created_at": FieldValue.serverTimestamp()
//       });
//     });
//     batchWrite.setData(firestore.collection("messages").document(), {
//       "message": "Batched message created",
//       "created_at": FieldValue.serverTimestamp()
//     });
//     batchWrite.delete(
//         querySnapshot.documents[querySnapshot.documents.length - 2].reference);
//     batchWrite.delete(querySnapshot.documents.last.reference);
//     await batchWrite.commit();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firestore Example'),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: _runTransaction,
//             child: Text("Run Transaction"),
//           ),
//           FlatButton(
//             onPressed: _runBatchWrite,
//             child: Text("Batch Write"),
//           )
//         ],
//       ),
//       body: MessageList(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addMessage,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
