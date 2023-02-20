import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fit_together/screens/display_picture_screen.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/storage.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    required this.camera,
    Key? key,
  }) : super(key: key);

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take a picture"),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () {
          _initializeControllerFuture.then(
                  (_) {
                _cameraController.takePicture().then(
                        (imageFile) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DisplayPictureScreen(imagePath: imageFile.path),
                        ),
                      );
                      //TODO: save taken photo to storage
                      // final storageService = locator<StorageService>();
                      // storageService.addImageFile(File(imageFile.name));
                    },
                    onError: (error) => debugPrint("Error: $error")
                );
              },
              onError: (error) => debugPrint("Error: $error")
          );
        },
      ),
    );
  }
}
