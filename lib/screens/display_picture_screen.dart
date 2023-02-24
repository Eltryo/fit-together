import 'dart:io';

import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/storage.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit the picture")),
      body: SizedBox(
        //TODO: eventually fix size of image (not exact size as camera preview)
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () {
          final storageService = locator<StorageService>();
          storageService.addImageFile(File(imagePath));
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}