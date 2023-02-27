import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_together/models/picture.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter/cupertino.dart';

class StorageService {
  static final _firebaseStorageRef = FirebaseStorage.instance.ref();

  void addImageFile(File file) {
    final uid = locator<AuthenticationService>().currentUid!;
    _firebaseStorageRef
        .child("users/$uid/images/${_getFilename(file.path)}")
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
            final picture =
                Picture(path: taskSnapshot.ref.fullPath, ownerId: uid);
            firestoreService.addImage(picture);
            //TODO: update picture count on user stats and add picture entry to firestore database
            break;
        }
      },
    );
  }

  Future<Iterable<Uint8List?>> getAllImages(String uid) {
    final uid = locator<AuthenticationService>().currentUid;
    return _firebaseStorageRef.child("users/$uid/images").listAll().then(
      (listResult) {
        final imageDataList = Future.wait(
          listResult.items.map(
            (imageRef) => imageRef.getData(),
          ),
        );
        return imageDataList;
      },
    );
  }

  Future<bool> imageExists(String path) {
    final uid = locator<AuthenticationService>().currentUid;
    return _firebaseStorageRef
        .child("users/$uid/images/${_getFilename(path)}")
        .getDownloadURL()
        .then(
      (value) => true,
      onError: (error) {
        debugPrint("Error: $error");
        return false;
      },
    );
  }

  String? _getFilename(String path) {
    return path.isEmpty ? null : path.split("/").last;
  }
}
