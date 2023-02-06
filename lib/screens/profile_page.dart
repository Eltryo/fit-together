import 'package:fit_together/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/profile_image_widget.dart';
import '../widgets/profile_stats_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String _username = "";
  String _email = "";
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    fetchAppUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        ProfileImage(
          imagePath: _checkImagePath(_imageUrl),
          onClicked: () {},
        ),
        const SizedBox(height: 10),
        Text(
          _username,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          _email,
          style:
              const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        const ProfileStats(),
      ],
    );
  }

  String _checkImagePath(String? imagePath) {
    if (imagePath == null) {
      return "assets/images/default_user_image.png";
    }
    return imagePath;
  }

  void fetchAppUser() {
    final authService = ref.read(authServiceProvider);
    final firestoreService = ref.read(firestoreServiceProvider);
    if (authService.currentUid != null) {
      firestoreService.getUserByUid(authService.currentUid!).then(
        (appUser) {
          setState(
            () {
              _username = appUser.username;
              _email = appUser.email;
              _imageUrl = appUser.imageUrl;
            },
          );
        },
        onError: (error) => debugPrint("Error: $error")
      );
    }
  }
}
