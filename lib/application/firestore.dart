import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_together/application/authentication.dart';
import 'package:fit_together/domain/post.dart';
import 'package:fit_together/service_locator.dart';
import 'package:flutter/cupertino.dart';

import '../domain/app_user.dart';

class FirestoreService {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  final uid = locator<AuthenticationService>().currentUid;

  Future<void> addUser(EmailUsernameDto appUserDto) {
    return _firebaseFirestore
        .collection("users")
        .doc(uid!)
        .get()
        .then((doc) => {
              if (!doc.exists)
                {
                  doc.reference
                      .set(appUserDto.toJson())
                      .catchError((error) => debugPrint("Error: $error"))
                }
            });
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

  Future<AppUser> getUserByUid(String uid) {
    return _firebaseFirestore
        .collection("users")
        .doc(uid)
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

  Future<void> addImage(Post picture) {
    return _firebaseFirestore.collection("pictures").add(picture.toJson()).then(
      (picture) {
        _firebaseFirestore.collection("users").doc(uid!).update(
          {
            "appUserStats.pictureCount": FieldValue.increment(1),
          },
        );
      },
      onError: (error) => debugPrint("Error : $error"),
    );
  }
}
