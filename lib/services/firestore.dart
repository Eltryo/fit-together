import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static void addUser() {
    //TODO: replace with business logic
    final user = <String, dynamic>{
      "firstName": "David",
      "lastName": "Merkl",
    };

    db.collection("users").add(user).then((DocumentReference doc) =>
        debugPrint("Successfully add document with ID: ${doc.id}"));
  }

  static void getUser() {
    db.collection("users").get().then((event) => {
          for (var doc in event.docs) {debugPrint("${doc.id} => ${doc.data()}")}
        });
  }
}
