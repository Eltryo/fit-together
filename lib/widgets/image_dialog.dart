import 'dart:typed_data';

import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final Uint8List imageData;

  const ImageDialog({required this.imageData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestoreService = locator<FirestoreService>();
    final authenticationService = locator<AuthenticationService>();
    final appUserFuture =
        firestoreService.getUserById(authenticationService.currentUid!);

    return Dialog(
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(imageData),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
    );
  }
}
