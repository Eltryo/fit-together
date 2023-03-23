import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/application/storage.dart';
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
  late StorageService _storageService;
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.max);
    _initializeControllerFuture = _cameraController.initialize();
    _storageService = locator<StorageService>();
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
            final size = MediaQuery.of(context).size;
            return SizedBox(
              width: size.width,
              height: size.height,
              child: AspectRatio(
                aspectRatio: _cameraController.value.aspectRatio,
                child: CameraPreview(_cameraController),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () => _initializeControllerFuture.then(
          (_) => _cameraController.takePicture().then(
            (imageFile) {
              _storageService.addImageFile(File(imageFile.path));
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            onError: (error) => debugPrint("Error: $error"),
          ),
          onError: (error) => debugPrint("Error: $error"),
        ),
      ),
    );
  }
}
