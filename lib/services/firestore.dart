import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/app_user.dart';

class FirestoreService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  void addUser(AppUser appUser) {
    //TODO: check if username already exists
    db.collection("users").add(appUser.toJson()).then(
          (DocumentReference doc) =>
              debugPrint("Successfully add document with ID: ${doc.id}"),
          onError: (error) => debugPrint("Error: $error"),
        );
  }

  Future<Iterable<AppUser>> getUsers() {
    return db
        .collection("users")
        .withConverter(
          fromFirestore: AppUser.fromJson,
          toFirestore: (AppUser appUser, _) => appUser.toJson(),
        )
        .get()
        .then(
          (colSnap) => colSnap.docs.map((docSnap) => docSnap.data()),
          onError: (error) => debugPrint("Error: $error"),
        );
  }

  Future<AppUser> getUserByUid(String uid) {
    return db
        .collection("users")
        .withConverter(
            fromFirestore: AppUser.fromJson,
            toFirestore: (AppUser appUser, _) => appUser.toJson())
        .where("uid", isEqualTo: uid)
        .get()
        .then(
          (colSnap) => colSnap.docs.map((docSnap) => docSnap.data()).single,
          onError: (error) => debugPrint("Error: $error"),
        );
  }
}
