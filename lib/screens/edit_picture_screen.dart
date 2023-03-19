import 'dart:io';

import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/storage.dart';
import 'package:flutter/material.dart';

class EditPictureScreen extends StatelessWidget {
  final storageService = locator<StorageService>();
  final String imagePath;

  EditPictureScreen({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: add edit functionality
    return Scaffold(
      appBar: AppBar(title: const Text("Edit the picture")),
      body: SizedBox(
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
          storageService.addImageFile(File(imagePath));
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
