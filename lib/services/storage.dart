import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageService {
  static final _firebaseStorageRef = FirebaseStorage.instance.ref();

  void addImageFile(File file) {
    _firebaseStorageRef
        .child("images/$file") //TODO: get file name
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
            break;
        }
      },
    );
  }

  void getAllImageFiles() {
    _firebaseStorageRef
        .child("images")
        .listAll()
        .then((images) => images.items.map((image) => image.getData()));
  }
}
