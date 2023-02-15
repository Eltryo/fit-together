import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/app_user.dart';

//TODO: test api, implement delete and update logic
class FirestoreService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addUser(String uid, AppUser appUser) {
    return db
        .collection("users")
        .doc(uid)
        .set(appUser.toJson())
        .catchError((error, _) => debugPrint("Error: $error")); //TODO fix error handler error
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
          onError: (error) => debugPrint("Error: $error"),
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
          onError: (error) => debugPrint("Error: $error"),
        );
  }
}
