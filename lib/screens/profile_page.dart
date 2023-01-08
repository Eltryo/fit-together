import 'package:flutter/material.dart';
import 'package:fit_together/services/auth.dart';
import 'package:fit_together/services/firestore.dart';

import '../models/app_user.dart';
import '../widgets/profile_image_widget.dart';
import '../widgets/profile_stats_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
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
          onClicked: () async {},
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

  void fetchAppUser() async {
    String? currentUID = await _authService.getCurrentUID();
    if (currentUID == null) throw Exception(); //TODO: throw custom exception
    AppUser appUser = await _firestoreService.getUserByUID(currentUID);
    setState(() {
      _username = appUser.username;
      _email = appUser.email;
      _imageUrl = appUser.imageUrl;
    });
  }
}
