import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fit_together/screens/take_picture_screen.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:fit_together/services/storage.dart';
import 'package:fit_together/widgets/profile_page_posts.dart';
import 'package:fit_together/widgets/shimmer_loading.dart';
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
  String _username = "";
  String _email = "";
  String? _imageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ProfileImage(
                imagePath: _imageUrl ?? "assets/images/default_user_image.png",
                onClicked: () {},
              ),
              const SizedBox(height: 10),
              buildText(
                Text(
                  _username, //TODO: use null check
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 3),
              buildText(
                Text(
                  _email, //TODO: use null check
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              const ProfileStats(),
              const SizedBox(height: 20),
              const ProfilePagePosts()
            ],
          ),
        ),
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
                        availableCameras().then(
                          (cameras) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TakePictureScreen(camera: cameras.first),
                              ),
                            );
                          },
                          onError: (error) => debugPrint("Error: $error"),
                        );
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

  Widget buildText(Text text) {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: _isLoading
          ? Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 15, //TODO change hardcoded height
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            )
          : text,
    );
  }

  void fetchAppUserData() {
    if (authService.currentUid != null) {
      firestoreService.getUserById(authService.currentUid!).then(
        (appUser) {
          setState(
            () {
              _username = appUser.username;
              _email = appUser.email;
              _imageUrl = appUser.imageUrl;
              _isLoading = false;
            },
          );
        },
        onError: (error) => debugPrint("Error: $error"),
      );
    }
  }
}
