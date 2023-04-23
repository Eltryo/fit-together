import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fit_together/domain/app_user_stats.dart';
import 'package:fit_together/presentation/home/profile/edit_profile_page.dart';
import 'package:fit_together/presentation/take_picture_screen.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/application/authentication.dart';
import 'package:fit_together/application/firestore.dart';
import 'package:fit_together/application/storage.dart';
import 'package:fit_together/presentation/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthenticationService _authenticationService;
  late FirestoreService _firestoreService;
  late StorageService _storageService;

  @override
  void initState() {
    super.initState();
    _authenticationService = locator<AuthenticationService>();
    _firestoreService = locator<FirestoreService>();
    _storageService = locator<StorageService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firestoreService
                .getUserByUid(_authenticationService.currentUid!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final appUser = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () => Future.delayed(
                    const Duration(seconds: 1),
                    () => setState(() {}),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        _buildProfileImage(appUser.imageUrl),
                        const SizedBox(height: 10),
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
                        _buildProfileStats(appUser.appUserStats),
                        const SizedBox(height: 20),
                        FutureBuilder(
                          future: _buildProfilePagePosts(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) return snapshot.data!;
                            if (snapshot.hasError) {
                              debugPrint("Error: ${snapshot.error}");
                            }
                            return const SizedBox.shrink();
                          },
                        )
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                debugPrint("Error: ${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  Widget _buildProfileStats(AppUserStats appUserStats) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton("Pictures", appUserStats.pictureCount),
        _buildDivider(),
        _buildButton("Following", appUserStats.followingCount),
        _buildDivider(),
        _buildButton("Follower", appUserStats.followerCount),
      ],
    );
  }

  Widget _buildButton(String text, int value) {
    return MaterialButton(
      //TODO: implement button functionality
      onPressed: () {},
      child: Column(
        children: [
          Text(value.toString()),
          const SizedBox(height: 2),
          Text(text)
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const SizedBox(
      height: 24,
      child: VerticalDivider(),
    );
  }

  Widget _buildProfileImage(String? imagePath) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage:
                AssetImage(imagePath ?? "assets/images/default_user_image.png"),
            radius: 50,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfilePage()),
              ),
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(3),
                  child: ClipOval(
                    child: Container(
                      color: Colors.teal,
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
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
                  Navigator.pop(context);
                },
                child: const Text("From Camera"),
              )
            ],
          ),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }

  //TODO: reload page after image was added
  void _pickImageFromCamera() {
    availableCameras().then(
      (cameras) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePictureScreen(camera: cameras.first),
        ),
      ),
      onError: (error) => debugPrint("Error: $error"),
    );
  }

  void _pickImageFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then(
          (image) => _storageService.addImageFile(File(image!.path)),
          onError: (error) => debugPrint("Error: $error"),
        );
  }

  //TODO: display images in chronological order
  Future<Widget> _buildProfilePagePosts() async {
    await _storageService.downloadToFiles();
    final appDocDir = await getApplicationDocumentsDirectory();
    final imageDir = Directory("${appDocDir.absolute.path}/images");
    final fileList = await imageDir
        .list()
        .map(
          (entity) => entity as File,
        )
        .toList();

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: List.generate(
        fileList.length,
        (index) {
          final file = fileList.elementAt(index);
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => ImageDialog(image: FileImage(file)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(file),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(3),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
