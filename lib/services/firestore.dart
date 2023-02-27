import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_together/models/picture.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:flutter/cupertino.dart';

import '../models/app_user.dart';

class FirestoreService {
  //TODO: test api, implement delete and update logic
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  Future<void> addUser(String uid, AppUser appUser) {
    return _firebaseFirestore
        .collection("users")
        .doc(uid)
        .set(appUser.toJson())
        .catchError((error) => debugPrint("Error: $error"));
  }

  Future<Iterable<AppUser>> getUsers() {
    return _firebaseFirestore
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

  Future<AppUser> getUserById(String id) {
    return _firebaseFirestore
        .collection("users")
        .doc(id)
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (appUser, _) => appUser.toJson(),
        )
        .get()
        .then(
          (docSnap) => docSnap.data()!,
          onError: (error) => debugPrint("Error: $error"),
        );
  }

  //TODO: add picture collection
  Future<void> addImage(Picture picture) {
    return _firebaseFirestore.collection("pictures").add(picture.toJson()).then(
      (picture) {
        final uid = locator<AuthenticationService>().currentUid!;
        //TODO: update picture count
        _firebaseFirestore.collection("users").doc(uid).update(
          {
            "appUserStats.pictureCount": FieldValue.increment(1),
          },
        );
      },
      onError: (error) => debugPrint("Error: $error"),
    );
  }
}
