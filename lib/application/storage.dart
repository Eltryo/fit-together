import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_together/application/authentication.dart';
import 'package:fit_together/application/firestore.dart';
import 'package:fit_together/domain/post.dart';
import 'package:fit_together/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

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
            final picture = Post(
              path: taskSnapshot.ref.fullPath,
              ownerId: uid,
            );
            firestoreService.addImage(picture);
            break;
        }
      },
    );
  }

  Future<void> downloadToFiles() async {
    final uid = locator<AuthenticationService>().currentUid;
    final appDocDir = await getApplicationDocumentsDirectory();
    final imageDir = Directory("${appDocDir.absolute.path}/images");

    await _firebaseStorageRef.child("users/$uid/images").listAll().then(
      (listResult) async {
        for (var imageRef in listResult.items) {
          final file = await File("${imageDir.absolute.path}/${imageRef.name}")
              .create(recursive: true);
          final downloadTask = imageRef.writeToFile(file);

          downloadTask.snapshotEvents.listen(
            (taskSnapshot) {
              switch (taskSnapshot.state) {
                case TaskState.running:
                  // TODO: Handle this case.
                  debugPrint("Download running");
                  break;
                case TaskState.paused:
                  // TODO: Handle this case.
                  debugPrint("Download paused");
                  break;
                case TaskState.success:
                  // TODO: Handle this case.
                  debugPrint("Download successful");
                  break;
                case TaskState.canceled:
                  // TODO: Handle this case.
                  debugPrint("Download canceled");
                  break;
                case TaskState.error:
                  // TODO: Handle this case.
                  debugPrint("Error occurred");
                  break;
              }
            },
          );
        }
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
