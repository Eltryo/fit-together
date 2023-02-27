import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fit_together/screens/take_picture_screen.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:fit_together/services/storage.dart';
import 'package:fit_together/widgets/profile_page_posts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/profile_image_widget.dart';
import '../widgets/profile_stats_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = locator<AuthenticationService>();
  final firestoreService = locator<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //TODO: fix refresh
        RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
              () {
                setState(() {});
              },
            );
          },
          child: FutureBuilder(
            future: firestoreService.getUserById(authService.currentUid!),
            builder: (context, snapshot) {
              //TODO: handle error
              if (snapshot.hasData) {
                final appUser = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ProfileImage(
                        imagePath: appUser.imageUrl ??
                            "assets/images/default_user_image.png",
                        onClicked: () {},
                      ),
                      const SizedBox(height: 10),
                      // buildText(
                      Text(
                        appUser.username,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        appUser.email,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      ProfileStats(appUserStats: appUser.appUserStats),
                      const SizedBox(height: 20),
                      const ProfilePagePosts()
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        //TODO: eventually use scaffold
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.all(kFloatingActionButtonMargin),
          child: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _pickImageFromGallery();
                        Navigator.pop(context);
                      },
                      child: const Text("From Gallery"),
                    ),
                    TextButton(
                      onPressed: () {
                        _pickImageFromCamera();
                      },
                      child: const Text("From Camera"),
                    )
                  ],
                ),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  //TODO: reload page after image was added
  void _pickImageFromCamera() {
    availableCameras().then(
      (cameras) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TakePictureScreen(camera: cameras.first),
          ),
        );
      },
      onError: (error) => debugPrint("Error: $error"),
    );
  }

  void _pickImageFromGallery() {
    final storageService = locator<StorageService>();
    ImagePicker().pickImage(source: ImageSource.gallery).then(
      (image) {
        storageService.addImageFile(
          File(image!.path),
        );
      },
      onError: (error) => debugPrint("Error: $error"),
    );
  }
}
