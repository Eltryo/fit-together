import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter/cupertino.dart';

class StorageService {
  static final _firebaseStorageRef = FirebaseStorage.instance.ref();

  void addImageFile(File file) {
    final uid = locator<AuthenticationService>().currentUid;

    _firebaseStorageRef
        .child("users/$uid/images/${getFilename(file)}")
        .putFile(file)
        .snapshotEvents
        .listen(
      (TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            debugPrint("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            debugPrint("Upload is paused.");
            break;
          case TaskState.canceled:
            debugPrint("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            debugPrint("Upload was unsuccessful");
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            debugPrint("Upload was successful");
            final firestoreService = locator<FirestoreService>();
            //TODO: update user stats or removing app user stats
            break;
        }
      },
    );
  }

  Future<Iterable<Future<Uint8List?>>> getAllImageFiles(String uid) {
    return _firebaseStorageRef.child("users/$uid/images").listAll().then(
        (listResult) => listResult.items.map((imageRef) => imageRef.getData()));
  }

  String? getFilename(File file) {
    return file.path.isEmpty ? null : file.path.split("/").last;
  }
}
