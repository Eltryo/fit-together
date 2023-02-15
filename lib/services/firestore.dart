import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/app_user.dart';

//TODO: test api, implement delete and update logic
class FirestoreService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addUser(AppUser appUser) {
    return getUserByUid(appUser.uid).then((appUser) => null).catchError(
      (error) {
        if (error.message == "No element") {
          db.collection("users").add(appUser.toJson()).then(
                (doc) =>
                    debugPrint("Successfully add document with ID: ${doc.id}"),
                onError: (error) =>
                    debugPrint("Error in firestore line 17: $error"),
              );
        }
      },
      test: (error) => error is StateError,
    );
  }

  Future<Iterable<AppUser>> getUsers() {
    return db
        .collection("users")
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (appUser, _) => appUser.toJson(),
        )
        .get()
        .then(
          (colSnap) => colSnap.docs.map((docSnap) => docSnap.data()),
        );
  }

  Future<AppUser> getUserByUid(String uid) {
    return db
        .collection("users")
        .withConverter(
            fromFirestore: AppUser.fromFirestore,
            toFirestore: (appUser, _) => appUser.toJson())
        .where("uid", isEqualTo: uid)
        .get()
        .then(
          (colSnap) => colSnap.docs.map((docSnap) => docSnap.data()).single,
        );
  }
}
