import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/app_user.dart';

class FirestoreService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  void addUser(AppUser profileData) {
    db
        .collection("users")
        .add(profileData.toJson())
        .then((DocumentReference doc) =>
            debugPrint("Successfully add document with ID: ${doc.id}"))
        .onError((error, stackTrace) => stackTrace.toString());
  }

  void getUsers() {
    db.collection("users").get().then((collection) => {
          for (var doc in collection.docs)
            {debugPrint("${doc.id} => ${doc.data()}")}
        });
  }
}
